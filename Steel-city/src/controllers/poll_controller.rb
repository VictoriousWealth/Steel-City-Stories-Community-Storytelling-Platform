require "require_all"

get "/add-poll/:storyid" do
    @story_id = params[:storyid].to_i
    erb :create_poll
end

post "/create-poll/:storyid" do
    @story_id = params[:storyid].to_i
    @question = params.fetch("poll_question","")
    @options_num = params.fetch("optionsnum","").to_i
    begin
        db = SQLite3::Database.new 'database.sqlite3'
        poll=Poll.new
        max_poll=Poll.max(:pollid) || 1
        poll.pollid=max_poll+1
        @poll_id = max_poll+1
        poll.writerid=session["currentuser"]
        poll.storyid=@story_id
        poll.question=@question
        poll.save_changes
    rescue SQLite3::Exception => e
      @error = "Database error: #{e.message}"
    ensure
      db.close if db
    end
    erb :create_poll
end

post "/add-poll-options/:pollid" do
    @poll_id = params[:pollid].to_i
    @options_num = params[:options_num].to_i
    @options = []
    @options_num.times do |i|
        @options[i] = params.fetch("poll_option_#{i}","")
    end
    begin
        db = SQLite3::Database.new 'database.sqlite3'
        @options_num.times do |i|
            poll_option=PollOption.new
            poll_option.pollid=@poll_id
            poll_option.optionid=i+1
            poll_option.optionvotes=0
            poll_option.optiontext=@options[i]
            poll_option.save_changes
        end
    rescue SQLite3::Exception => e
      @error = "Database error: #{e.message}"
    ensure
      db.close if db
    end
    redirect "/"
    erb :create_poll
end

def checkIfPoll(storyid)
  begin
    db = SQLite3::Database.new 'database.sqlite3'
    sql = "SELECT * FROM polls WHERE storyid = ?"
    check = db.get_first_value(sql,storyid)
    if check.nil? 
      return false
    else 
      return true
    end
  rescue SQLite3::Exception => e
     @error = "Database error: #{e.message}"
  ensure
    db.close if db
  end
end

def getPollList(storyid)
  begin
    db = SQLite3::Database.new 'database.sqlite3'
      sql = "SELECT question, pollid FROM polls WHERE storyid = ?"
      result = db.execute(sql,storyid)
      @poll_list = result.map do |row|
        {
          question: row[0], 
          pollid: row[1],
        }
      end
  rescue SQLite3::Exception => e
    @error = "Database error: #{e.message}"
  ensure
    db.close if db
  end
end

def getPollOptions(pollid)
  begin
    db = SQLite3::Database.new 'database.sqlite3'
      sql = "SELECT optiontext, optionid, optionvotes FROM poll_options WHERE pollid = ?"
      result = db.execute(sql,pollid)
      @option_list = result.map do |row|
        {
          option: row[0], 
          optionid: row[1],
          optionvotes: row[2],
        }
      end
  rescue SQLite3::Exception => e
    @error = "Database error: #{e.message}"
  ensure
    db.close if db
  end
end

def checkIfAlreadyVoted(pollid)
  begin
    db = SQLite3::Database.new 'database.sqlite3'
    sql = "SELECT * FROM votes WHERE pollid = ? AND userid = ?"
    check = db.get_first_value(sql,pollid, session["currentuser"])
    if check.nil? 
      return false
    else 
      return true
    end
  rescue SQLite3::Exception => e
     @error = "Database error: #{e.message}"
  ensure
    db.close if db
  end
end

get "/cast-vote/:pollid/:optionid/:storyid" do
  pollid = params[:pollid]
  optionid = params[:optionid]
  storyid = params[:storyid]
  begin
    db = SQLite3::Database.new 'database.sqlite3'
    vote = Vote.new
    vote.userid = session["currentuser"]
    vote.pollid=pollid
    vote.optionid=optionid
    vote.save_changes

    sql = "SELECT optionvotes FROM poll_options WHERE pollid = ? AND optionid = ?"
    currentvotes = db.get_first_value(sql,pollid,optionid).to_i
    currentvotes = currentvotes+1
    sql = "UPDATE poll_options SET optionvotes = ? WHERE pollid = ? AND optionid = ?"
    db.execute(sql,currentvotes,pollid,optionid)

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
redirect "/story-page/#{storyid}"
end