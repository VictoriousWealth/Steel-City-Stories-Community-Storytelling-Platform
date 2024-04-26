require "require_all"

get "/common/header" do
  erb :header
end

get "/" do
  @myTitle = "home"
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
    @error = nil
    begin
      db = SQLite3::Database.new 'database.sqlite3'
        user=User.new
        numusers=User.all.count()
        user.userid=numusers+1
        user.username=@username
        user.password=@password
        user.email=@email
        user.dateofbirth=@dob
        user.type=@account_type
        user.premium=0
        user.popcorns=0
        user.activediscount=1
        user.interactions=0
        user.save_changes
        session["logged_in"] = true
        if @account_type=="reader" then
          session["type"] = "reader"
        elsif @account_type=="writer" then
          session["type"] = "writer"
        elsif @account_type=="admin" then
          session["type"] = "admin"
        elsif type=="manager" then
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
    erb :home
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
        @error="Usernot logged in"
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