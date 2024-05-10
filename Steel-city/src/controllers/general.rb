require "require_all"


get "/common/header" do
  erb :header
end


get "/" do
  @myTitle = "Home"
  num_stories=Story.all.count() #use if we randomise the home page stories or implement likes into stories and choose most liked
  @stories = Story.all
  erb :home
end


get "/promotions" do
  @myTitle = "Promotional Campaigns"
  erb :promotional_campaigns
end


get "/login" do
    @database = nil
    begin
        db = SQLite3::Database.new 'database.sqlite3'
        sql = "SELECT * FROM users"
        @database = db.execute(sql)
    rescue SQLite3::Exception => e
        @error = "Database error: #{e.message}"
    ensure
        db.close if db
    end
    erb :login_page
end


get "/account-settings" do
  @myTitle = "Account Settings"
  erb :account_settings
end


get "/contact-staff" do
  @myTitle = "Account Settings"
  erb :staff_contact_page
end


get "/create-account" do
  erb :create_account
end


post "/create-account" do
    @username = params.fetch("username", "")
    @password = params.fetch("password", "")
    @confirm_password = params.fetch("confirm_password","")
    @dob = params.fetch("dob","")
    Date.parse(@dob)
    @email = params.fetch("email","")
    @account_type = params.fetch("account_type","")
    @error = nil
    begin
      db = SQLite3::Database.new 'database.sqlite3'
      sql = "SELECT * FROM users WHERE email = ? LIMIT 1"
      check_email = db.execute(sql,@email)
      sql = "SELECT * FROM users WHERE username = ? LIMIT 1"
      check_username = db.execute(sql, @username)
      if !check_username.empty?
        @error="Username already taken"
      elsif @password!=@confirm_password
        @error="Ensure that the passwords match"
      elsif get_password_strength(@password) < 3
        @error="Password is too weak. Password strength is "+get_password_strength(@password).to_s
        +". Password strength should be at least 3."
      elsif @dob.empty? || Date.parse(@dob) > Date.today - (13 * 365.25)
        @error="Invalid Date of Birth"
      elsif !check_email.empty?
        @error="Email already in use"
      elsif @account_type.empty?
        @error="Choose an account type! Reader or Writer."
      else
        user=User.new
        numusers=User.max(:userid) || 1
        user.userid=numusers+1
        user.username=@username
        user.password=@password
        user.email=@email
        user.dateofbirth=@dob
        user.type=@account_type
        user.premium=0
        user.popcorns=0
        user.compounds=0
        user.activediscount=1
        user.interactions=0
        user.save_changes
        session["logged_in"] = true
        session["cart"] = {}
        if @account_type=="reader" then
          session["type"] = "reader"
        elsif @account_type=="writer" then
          session["type"] = "writer"
        elsif @account_type=="admin" then
          session["type"] = "admin"
        elsif @account_type=="manager" then
          session["type"] = "manager"
        end
        sql = "SELECT userid FROM users WHERE username = ? LIMIT 1"
        session["currentuser"] = db.execute(sql,@username)
        redirect "/"
      end
    rescue SQLite3::Exception => e
      @error = "Database error: #{e.message}"
    ensure
      db.close if db
    end
    erb :create_account
end


def get_password_strength(password)
  strength = 0
  strength += 1 if password.length >= 8
  strength += 1 if password.match?(/[A-Z]/)
  strength += 1 if password.match?(/[a-z]/)
  strength += 1 if password.match?(/\d/)
  strength += 1 if password.match?(/[!@#$%^&*]/)
  strength
end


post "/login" do
    @username = params.fetch("username", "")
    @password = params.fetch("password", "")
    @error = nil


    if @username != "" and @password != "" then
      if !User.where(username: @username).empty? then

        entered_password=User.first(username: @username).password
        type=User.first(username: @username).type
   
        if @password==entered_password
          session["logged_in"] = true
          session["cart"] = {}
          premium = PremiumSubscription.first(userid: session["currentuser"])
          if premium.nil? || DateTime.parse(premium.startdate) + premium.length.to_i < DateTime.now
            User.first(username: @username).update(premium: 0)
            User.first(username: @username).update(activediscount: 1)
          else
            User.first(username: @username).update(premium: 1)
            User.first(username: @username).update(activediscount: 0.8)
          end

          if type=="reader" then
            session["type"] = "reader"
          elsif type=="writer" then
            session["type"] = "writer"
          elsif type=="admin" then
            session["type"] = "admin"
          elsif type=="manager" then
            session["type"] = "manager"
          end
          session["currentuser"] = User.first(username: @username).userid
          User.first(username: @username).compounds = 100.0
          updateCampaigns
          redirect "/"
        else
          @error = "Password incorrect"
        end
      else
        @error = "Username incorrect"
      end
    else
      @error = "Please ensure all fields have been filled in"
    end
    erb :login_page
end


get "/logout" do
    session.clear
    redirect "/"
end


post "/update-profile" do
    @username = params.fetch("username", "")
    @email = params.fetch("email", "")
    @error = nil
    begin
    db = SQLite3::Database.new 'database.sqlite3'
    sql = "UPDATE users SET username = ?, email = ? WHERE userid = ?"
    db.execute(sql,@username,@email,session["currentuser"])
  rescue SQLite3::Exception => e
    @error = "Database error: #{e.message}"
  ensure
    db.close if db
  end
  erb :account_settings
end


post "/change-password" do
  @currentpassword = params.fetch("currentPassword")
  @newpassword = params.fetch("newPassword")
  @confirmpassword = params.fetch("confirmPassword")
  @error=nil
  begin
    db = SQLite3::Database.new 'database.sqlite3'
    sql = "SELECT password FROM users WHERE userid = ? ORDER BY userid LIMIT 1"
    @checkpass=db.get_first_value(sql,session["currentuser"])
    if @checkpass!=@currentpassword
      @error="Passwords Incorrect"
    elsif @newpassword!=@confirmpassword
      @error="Passwords do not match"
    else
      sql = "UPDATE users SET password = ? WHERE userid = ?"
      db.execute(sql,@newpassword,session["currentuser"])
    end
  rescue SQLite3::Exception => e
    @error = "Database error: #{e.message}"
  ensure
    db.close if db
  end
  erb :account_settings
end


post "/delete-self" do
  @error=nil
  begin
    if session["currentuser"].nil?
        @error="User not logged in"
    end
  db = SQLite3::Database.new 'database.sqlite3'
  sql = "DELETE FROM users WHERE userid = ?"
  db.execute(sql,session["currentuser"])
rescue SQLite3::Exception => e
  @error = "Database error: #{e.message}"
ensure
  db.close if db
end
session.clear
redirect "/"
erb :account_settings
end


def checkIfTop10
    begin
      db = SQLite3::Database.new 'database.sqlite3'
      ten_percent = (0.1*User.all.count()).ceil
      sql = "SELECT userid, interactions FROM users ORDER BY interactions DESC LIMIT ?"
      users_array = db.execute(sql,ten_percent)
      top_10_userids = users_array.map { |user| user[0] }
      if top_10_userids.include?(session["currentuser"])
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


def checkIfCampaignAvailable
    begin
        db = SQLite3::Database.new 'database.sqlite3'
        sql = "SELECT * FROM promotional_campaigns WHERE startdate < ? AND enddate > ?"
        campaigns = db.execute(sql,Date.today.strftime("%Y-%m-%d"),Date.today.strftime("%Y-%m-%d"))
        if !campaigns.empty?
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


def getActiveCampaigns
    begin
        db = SQLite3::Database.new 'database.sqlite3'
          sql = "SELECT title, content, startdate, enddate, discount, campaignid  FROM promotional_campaigns WHERE startdate < ? AND enddate > ?"
          result = db.execute(sql,Date.today.strftime("%Y-%m-%d"),Date.today.strftime("%Y-%m-%d"))
          @campaign_list = result.map do |row|
            {
              title: row[0],
              content: row[1],  
              startdate: row[2],
              enddate: row[3],
              discount: row[4],
              campaignid: row[5],
            }
          end
      rescue SQLite3::Exception => e
        @error = "Database error: #{e.message}"
      ensure
        db.close if db
      end
    end


    def checkIfNotActive
        begin
            db = SQLite3::Database.new 'database.sqlite3'
            sql = "SELECT * FROM activated_campaigns WHERE userid = ?"
            campaigns = db.execute(sql,session["currentuser"])
            puts campaigns[0][0]
            if campaigns.empty?
              puts "should work"
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


    get "/activateDiscount/:campaignid" do
      campaign_id = params[:campaignid].to_i
        begin
            db = SQLite3::Database.new 'database.sqlite3'
             sql = "SELECT activediscount FROM users WHERE userid = ?"
             current_discount = db.get_first_value(sql,session["userfound"]).to_f
             sql = "SELECT discount FROM promotional_campaigns WHERE campaignid = ?"
             applied_discount = db.get_first_value(sql,campaign_id).to_f
             new_discount = current_discount * applied_discount
              sql = "UPDATE users SET activediscount = ? WHERE userid = ?"
              db.execute(sql,new_discount,session["userfound"])
              sql = "SELECT enddate FROM promotional_campaigns WHERE campaignid = ?"
              end_date = db.get_first_value(sql,campaign_id)
              active_campaign=ActivatedCampaign.new
            active_campaign.campaignid=campaign_id
            active_campaign.userid=session["currentuser"]
            active_campaign.enddate=end_date
            active_campaign.save_changes
            redirect "/"
          rescue SQLite3::Exception => e
            @error = "Database error: #{e.message}"
          ensure
            db.close if db
          end
        end


def updateCampaigns
  begin
    db = SQLite3::Database.new 'database.sqlite3'
    sql = "SELECT campaignid FROM activated_campaigns WHERE userid = ? AND enddate < ?"
    campaign = db.get_first_value(sql,session["currentuser"],Date.today.strftime("%Y-%m-%d"))
    if !campaign.nil?
      sql = "SELECT discount FROM promotional_campaigns WHERE campaignid = ?"
      discount = db.get_first_value(sql,campaign)
      sql = "SELECT activediscount FROM users WHERE userid = ?"
      current_discount = db.get_first_value(sql,session["currentuser"])
      update_discount = current_discount/discount
      sql = "UPDATE users SET activediscount = ? WHERE userid = ?"
      db.execute(sql,update_discount,session["currentuser"])
    end
  rescue SQLite3::Exception => e
    @error = "Database error: #{e.message}"
  ensure
    db.close if db
  end
end

def getLatestSubscriptions
    begin
        db = SQLite3::Database.new 'database.sqlite3'
        sql = "SELECT storyid, title, blurb FROM stories JOIN subscriptions ON subscriptions.latestupdate = stories.storyid WHERE subscriptions.readerid = ?"
        result = db.execute(sql,session["currentuser"])
          @latest_stories = result.map do |row|
            {
              storyid: row[0],
              title: row[1],  
              blurb: row[2],
            }
          end
      rescue SQLite3::Exception => e
        @error = "Database error: #{e.message}"
      ensure
        db.close if db
      end
end