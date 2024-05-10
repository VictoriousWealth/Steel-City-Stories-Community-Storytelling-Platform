require "require_all"


get "/create-story" do
  @myTitle = "Create"
  erb :writing_story_page
end


post "/buy-story/:storyid" do
  @error = nil
  story_id = params[:storyid].to_i


  if session["logged_in"] then
    @user_id = session["currentuser"]
  end


  begin
    db = SQLite3::Database.new 'database.sqlite3'
      if User.enough_popcorns?(story_id, @user_id) then
        story = Story[storyid: story_id]
        user = User[userid: @user_id]


        bought_story = BoughtStory.new
        bought_story.storyid = story_id
        bought_story.userid = @user_id
        bought_story.save_changes


        user.popcorns -= story.price
        user.save_changes
        
        sql = "SELECT writerid FROM stories WHERE storyid = ?"
        author_id = db.get_first_value(sql,story_id).to_i
        sql = "SELECT popcorns FROM users WHERE userid = ?"
        author_popcorns = db.get_first_value(sql,author_id)
        author_popcorns = author_popcorns + 0.5*story.price
        sql = "UPDATE users SET popcorns = ? WHERE userid = ?"
        db.execute(sql,author_popcorns,author_id)

        redirect "/buy-confirmation/#{story_id}"
      else
        session[:error_message] = "You don't have enough popcorns to purchase this story."
      end
  rescue SQLite3::Exception => e
    session[:error_message] = "Database error: #{e.message}"
  ensure
    db.close if db
  end
  redirect "story-page/#{story_id}"
end


get "/buy-confirmation/:storyid" do
    @story_id = params[:storyid].to_i
    @bought_story_title = Story[@story_id].title
    erb :buy_confirmation
end


get "/story-page/:storyid" do


  @error = nil
  @error = session.delete(:error_message) if session.key?(:error_message)
  story_id = params[:storyid].to_i
  story = Story[storyid: story_id]


  if session["logged_in"] then
    @user_id = session["currentuser"]
    user = User[userid: @user_id]
  end
  if session["logged_in"] && (BoughtStory.entry_exists?(story_id, @user_id) || story.writerid == @user_id) then
    @bought_story = true
  end

  language = params[:language] || 'en' # Default language is English
  if language != 'en' then
    @title = story.translate_text(story.title, language)
    @body = story.translate_text(story.content, language)
    @blurb = story.translate_text(story.blurb, language)
  else
    @title = story.title
    @body = story.content
    @blurb = story.blurb
  end
  
  @price = story.price
  @genre = story.genre
  @storyID = story.storyid
  @writerID = story.writerid
  begin
    db = SQLite3::Database.new 'database.sqlite3'
      sql = "SELECT username FROM users WHERE userid = ?"
      @author = db.get_first_value(sql,story.writerid)
  rescue SQLite3::Exception => e
    @error = "Database error: #{e.message}"
  ensure
    db.close if db
  end


  erb :story_page
end


post "/submit-story" do
    @title = params.fetch("story-title", "")
    @body = params.fetch("story-content", "")
    @genre = params.fetch("genre","")
    @blurb = params.fetch("blurb-content","")
    @price = params.fetch("price","")
    @language = params.fetch("language","")
    @error = nil
    if @price.to_f==0.0
        @error="Invalid price"
    end
    begin
      db = SQLite3::Database.new 'database.sqlite3'
        story=Story.new
        numstories=Story.count
        story.storyid=numstories+1
        story.title=@title
        story.content=@body
        story.price=@price.to_f
        story.blurb=@blurb
        story.genre=@genre
        story.releasedate=Date.today.strftime("%d/%m/%y")
        story.writerid=session["currentuser"]
        story.language=@language
        sql = "SELECT username FROM users WHERE userid = ?"
        @author = db.get_first_value(sql,story.writerid)
        @story_id = story.storyid
        story.save_changes
        sql = "UPDATE subscriptions SET latestupdate = ? WHERE writerid = ?"
        db.execute(sql,story.storyid,session["currentuser"])
        session["logged_in"] = true
       
    rescue SQLite3::Exception => e
      @error = "Database error: #{e.message}"
    ensure
      db.close if db
    end
    redirect "/story-page/#{@story_id}"
    erb :story_page
end


get "/user-stories/:userid" do
  user_id = params[:userid].to_i
  begin
    db = SQLite3::Database.new 'database.sqlite3'
      sql = "SELECT title, blurb, storyid FROM stories WHERE writerid = ?"
      result = db.execute(sql,user_id)
      @story_list = result.map do |row|
        {
          title: row[0],
          blurb: row[1],
          storyid: row[2]
        }
      end
  rescue SQLite3::Exception => e
    @error = "Database error: #{e.message}"
  ensure
    db.close if db
  end
 
  erb :user_stories
end


post '/search' do
  @query = params[:q]
  @users_results = []
  @stories_results = []
  begin
    DB = SQLite3::Database.new 'database.sqlite3'
    DB.results_as_hash = true
   
    user_results = DB.execute("SELECT username, userid FROM users WHERE type IS 'writer' AND lower(username) LIKE ?", "%#{@query.downcase}%")
    story_results = DB.execute("SELECT title, blurb, storyid FROM stories WHERE lower(title) LIKE ? OR lower(content) LIKE ?", ["%#{@query.downcase}%", "%#{@query.downcase}%"])
   
    @users_results = user_results.map do |row|
        {
          username: row[0],
          userid: row[1],
        }
      end

      @stories_results = story_results.map do |row|
        {
          title: row[0],
          blurb: row[1],
          storyid: row[2]
        }
      end
 
  rescue SQLite3::Exception => e
    @error = "Database error: #{e.message}"
  ensure
    DB.close if DB
  end
  erb :search_results
end


def getWriterId(storyid)
    begin
        db = SQLite3::Database.new 'database.sqlite3'
          sql = "SELECT writerid FROM stories WHERE storyid = ?"
          value = db.get_first_value(sql,storyid)
          if value.nil?
            return 0
          else
            return value
          end
      rescue SQLite3::Exception => e
        @error = "Database error: #{e.message}"
      ensure
        db.close if db
      end
end


get "/edit-story/:storyid" do
    @story_id = params[:storyid].to_i
    begin
      db = SQLite3::Database.new 'database.sqlite3'
        sql = "SELECT title, blurb, content, price, genre FROM stories WHERE storyid = ?"
        result = db.execute(sql,@story_id).first
        @title = result[0]
        @blurb = result[1]
        @content = result[2]
        @price = result[3]
        @genre = result[4]
    rescue SQLite3::Exception => e
      @error = "Database error: #{e.message}"
    ensure
      db.close if db
    end
   
    erb :editing_story_page
end


post "/edit-story/:storyid" do
    @story_id = params[:storyid].to_i
    @title = params.fetch("story-title", "")
    @body = params.fetch("story-content", "")
    @genre = params.fetch("genre","")
    @blurb = params.fetch("blurb-content","")
    @price = params.fetch("price","")
    @language = params.fetch("language","")
    @error = nil
    if @price.to_f==0.0
        @error="Invalid price"
    end
    begin
      db = SQLite3::Database.new 'database.sqlite3'
        sql = "UPDATE stories SET title = ?, content = ?, genre = ?, blurb = ?, price = ? language = ? WHERE storyid = ?"
        db.execute(sql,@title,@body,@genre,@blurb,@price,@language,@story_id)
        sql = "UPDATE subscriptions SET latestupdate = ? WHERE writerid = ?"
        db.execute(sql,@story_id,session["currentuser"])
    rescue SQLite3::Exception => e
      @error = "Database error: #{e.message}"
    ensure
      db.close if db
    end
    redirect "/story-page/#{@story_id}"
end

post "/subscribe/:author" do
    @author=params[:author]
    @story_id = params.fetch("story_id","")
    begin
      db = SQLite3::Database.new 'database.sqlite3'
        sql = "SELECT userid FROM users WHERE username = ?"
        author_id = db.get_first_value(sql,@author)
        subscription=Subscription.new
        subscription.readerid = session["currentuser"]
        subscription.writerid=author_id
        sql = "SELECT MAX(storyid) FROM stories WHERE writerid = ?"
        subscription.latestupdate = db.execute(sql,author_id)
        subscription.save_changes
    rescue SQLite3::Exception => e
      @error = "Database error: #{e.message}"
    ensure
      db.close if db
    end
    redirect "/story-page/#{@story_id}"
    erb :story_page
end

def checkNotSubbed(author)
  begin
    db = SQLite3::Database.new 'database.sqlite3'
      sql = "SELECT userid FROM users WHERE username = ?"
      author_id = db.get_first_value(sql,author)
      sql = "SELECT * FROM subscriptions WHERE writerid = ? AND readerid = ?"
      check = db.get_first_value(sql,author_id,session["currentuser"])
      if check.nil?
        return true
      else
        return false
      end
  rescue SQLite3::Exception => e
    @error = "Database error: #{e.message}"
  ensure
    db.close if db
  end
end

post "/unsubscribe/:author" do
  @author=params[:author]
  @story_id = params.fetch("story_id","")
  begin
    db = SQLite3::Database.new 'database.sqlite3'
      sql = "SELECT userid FROM users WHERE username = ?"
      author_id = db.get_first_value(sql,@author)
      sql = "DELETE FROM subscriptions WHERE readerid = ? AND writerid = ?"
      db.execute(sql,session["currentuser"],author_id)
  rescue SQLite3::Exception => e
    @error = "Database error: #{e.message}"
  ensure
    db.close if db
  end
  redirect "/story-page/#{@story_id}"
  erb :story_page
end

def checkNotLiked(story_id)
    begin
        db = SQLite3::Database.new 'database.sqlite3'
          sql = "SELECT * FROM likes WHERE storyid = ? AND userid = ?"
          check = db.get_first_value(sql,story_id,session["currentuser"])
          if check.nil?
            return true
          else
            return false
          end
      rescue SQLite3::Exception => e
        @error = "Database error: #{e.message}"
      ensure
        db.close if db
      end
end

post "/like/:storyID" do
    @story_id=params[:storyID]
    begin
      db = SQLite3::Database.new 'database.sqlite3'
        like=Like.new
        like.userid = session["currentuser"]
        like.storyid=@story_id
        like.save_changes
        sql = "SELECT interactions FROM users WHERE userid = ?"
    interactions = db.get_first_value(sql,session["currentuser"]).to_i
    interactions = interactions+1
    sql = "UPDATE users SET interactions = ? WHERE userid = ?"
    db.execute(sql,interactions,session["currentuser"])
    rescue SQLite3::Exception => e
      @error = "Database error: #{e.message}"
    ensure
      db.close if db
    end
    redirect "/story-page/#{@story_id}"
    erb :story_page
end