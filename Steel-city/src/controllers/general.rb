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
