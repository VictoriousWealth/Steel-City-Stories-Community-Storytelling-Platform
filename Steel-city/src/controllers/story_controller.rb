require "require_all"

get "/create-story" do
  @myTitle = "Create"
  erb :writing_story_page
end

get "/story-page/:storyid" do
  story_id = params[:storyid].to_i
  story = Story[storyid: story_id]
  @title = story.title
  @body = story.content
  @price = story.price
  @blurb = story.blurb
  @genre = story.genre
  @storyID = story.storyid

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
    @error = nil
    if @price.to_f==0.0
        @error="Invalid price"
    end
    begin
      db = SQLite3::Database.new 'database.sqlite3'
        story=Story.new
        numstories=Story.all.count()
        story.storyid=numstories+1
        story.title=@title
        story.content=@body
        story.price=@price.to_f
        story.blurb=@blurb
        story.genre=@genre
        story.releasedate=Date.today.strftime("%d/%m/%y")
        story.writerid=session["currentuser"]
        sql = "SELECT username FROM users WHERE userid = ?"
        @author = db.get_first_value(sql,story.writerid)
        @storyID = story.storyid
        story.save_changes
        session["logged_in"] = true
        
    rescue SQLite3::Exception => e
      @error = "Database error: #{e.message}"
    ensure
      db.close if db
    end
    #should redirect to relevant story page
    erb :story_page
end