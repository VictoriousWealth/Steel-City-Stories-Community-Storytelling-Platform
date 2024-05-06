require "require_all"

get "/staff-actions" do
  @myTitle = "Staff Actions"
  erb :staff_actions
end

get "/staff-tickets" do
  @myTitle = "Staff Tickets"
  erb :staff_tickets
end

post "/find-user" do
    @chosenusername = params.fetch("username","")
    @error = nil
    begin
      db = SQLite3::Database.new 'database.sqlite3'
      sql = "SELECT userid FROM users WHERE username = ? LIMIT 1"
      usersID = db.execute(sql,@chosenusername)
      if usersID.nil?
        session["userfound"] = ""
        @error="Username not found"
       else
        session["userfound"] = usersID
        end
    rescue SQLite3::Exception => e
      @error = "Database error: #{e.message}"
    ensure
      db.close if db
    end
    erb :staff_actions
end

post "/find-story" do
    @chosenstory = params.fetch("storyid","")
    @error = nil
    begin
      db = SQLite3::Database.new 'database.sqlite3'
      sql = "SELECT storyid FROM stories WHERE storyid = ? LIMIT 1"
      storyID = db.execute(sql,@chosenstory)
      if storyID.nil?
        session["storyfound"] = nil
        @error="Story ID not found"
       else
        session["storyfound"] = storyID
        end
    rescue SQLite3::Exception => e
      @error = "Database error: #{e.message}"
    ensure
      db.close if db
    end
    erb :staff_actions
end

post "/delete-account" do
    @error = nil
    begin
        if session["userfound"].empty?
            @error="Username not found"
        end
      db = SQLite3::Database.new 'database.sqlite3'
      sql = "DELETE FROM users WHERE userid = ?"
      db.execute(sql,session["userfound"])
    rescue SQLite3::Exception => e
      @error = "Database error: #{e.message}"
    ensure
      db.close if db
    end
    session["userfound"] = nil
    erb :staff_actions
end

post "/delete-story" do
    @error = nil
    begin
        if session["storyfound"].nil?
            @error="Story not found"
        end
      db = SQLite3::Database.new 'database.sqlite3'
      sql = "DELETE FROM stories WHERE storyid = ?"
      db.execute(sql,session["storyfound"])
    rescue SQLite3::Exception => e
      @error = "Database error: #{e.message}"
    ensure
      db.close if db
    end
    session["storyfound"] = nil
    erb :staff_actions
end

post "/edit-story" do
  #temporary
  redirect "/"
end

post "/edit-popcorns" do
  @popcorncount=params.fetch("popcorns","").to_i
  @error = nil
    begin
        if session["userfound"].nil?
            @error="User not found"
        end
      db = SQLite3::Database.new 'database.sqlite3'
      sql = "SELECT popcorns FROM users WHERE userid = ?"
      currentpopcorns = db.get_first_value(sql,session["userfound"]).to_i
      totalpopcorns = @popcorncount + currentpopcorns
      sql = "UPDATE users SET popcorns = ? WHERE userid = ?"
      db.execute(sql,totalpopcorns,session["userfound"])
    rescue SQLite3::Exception => e
      @error = "Database error: #{e.message}"
    ensure
      db.close if db
    end
    session["userfound"] = nil
    erb :staff_actions
end

post "/change-type" do
  account_type = params.fetch("account_type","")
  @error = nil
    begin
        if session["userfound"].nil?
            @error="User not found"
        end
      db = SQLite3::Database.new 'database.sqlite3'
      sql = "UPDATE users SET type = ? WHERE userid = ?"
      db.execute(sql,account_type,session["userfound"])
    rescue SQLite3::Exception => e
      @error = "Database error: #{e.message}"
    ensure
      db.close if db
    end
    session["userfound"] = nil
    erb :staff_actions
end

post "/send-form" do
    email = params.fetch("email", "")
    title = params.fetch("formember", "")
    body = params.fetch("feedback","")
    @error = nil
    begin
        db = SQLite3::Database.new 'database.sqlite3'
        contact=StaffContact.new
        numcontacts=StaffContact.all.count()
        if !session["currentuser"].nil?
            contact.requestid=numcontacts+1
            contact.userid=session["currentuser"]
            contact.email=email
            contact.title=title
            contact.feedback=body
            contact.save_changes
        else 
            @error = "Please log in"
        end
    rescue SQLite3::Exception => e
      @error = "Database error: #{e.message}"
    ensure
      db.close if db
    end
    erb :staff_contact_page
end

def get_tickets
  @error = nil
  begin
    db = SQLite3::Database.new 'database.sqlite3'
    sql = "SELECT * FROM staff_contacts"
    result = db.execute(sql)
    @staff_contacts = result.map do |row|
      {
        requestid: row[0],  
        userid: row[1],     
        email: row[2],      
        title: row[3],      
        feedback: row[4]    
      }
    end
    p @staff_contacts
  rescue SQLite3::Exception => e
    @error = "Database error: #{e.message}"
  ensure
    db.close if db
end
erb :staff_contact_page
end

post "/create-prom-campaign" do
    @title = params.fetch("title", "")
    @body = params.fetch("campaign-content", "")
    @start_date = params.fetch("start-date","")
    @end_date = params.fetch("end-date","")
    @discount = params.fetch("discount","")
    @error = nil
    if Date.parse(@start_date) < Date.today
        @error="Invalid start date"
    elsif Date.parse(@end_date) <Date.today
      @error="Invalid end date"
    elsif Date.parse(@start_date)>Date.parse(@end_date)
      @error = "Campaign ends before start date"
    end
    begin
      db = SQLite3::Database.new 'database.sqlite3'
        sql = "SELECT * FROM promotional_campaigns WHERE enddate > ?"
        current_campaigns = db.execute(sql,@start_date)
        if !current_campaigns.empty?
          @error = "Active campaign at that time"
        end
        campaign=PromotionalCampaign.new
        numcampaigns=PromotionalCampaign.all.count()
        campaign.campaignid=numcampaigns+1
        campaign.title=@title
        campaign.content=@body
        campaign.managerid=session["currentuser"]
        campaign.discount=@discount
        campaign.startdate=@start_date
        campaign.enddate=@end_date
        campaign.save_changes     
    rescue SQLite3::Exception => e
      @error = "Database error: #{e.message}"
    ensure
      db.close if db
    end
    #should redirect to relevant story page
    erb :staff_actions
end