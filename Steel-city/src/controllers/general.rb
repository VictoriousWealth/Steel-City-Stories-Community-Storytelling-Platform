require "require_all"

class User < Sequel::Model
end

get "/common/header" do
  @myTitle = "Team 25"
  erb :header
end

get "/" do
  erb :home
end

get "/login" do 
  erb :login_Page
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
    sql = "SELECT * FROM users WHERE email = ? LIMIT 1"
    check_email = db.execute(sql,@email)
    sql = "SELECT * FROM users WHERE username = ? LIMIT 1"
    check_username = db.execute(sql, @username)
    if @password!=@confirm_password
      @error="Passwords do not match"
    elsif check_username
      @error="Username already in use"
    elsif check_email
      @error="Email already in use"
    elsif @dob<Date.today-15*365.25
      @error="Invalid Date of Birth"
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
      user.save_changes
      redirect "/"
    end
    @error = nil
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
            session["reader"] = true
          elsif type=="writer" then
            session["writer"] = true
          elsif type=="staff" then
            session["staff"] = true
          end

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
  
    erb :login_Page
end

get "/logout" do
    session.clear
    erb :home
end
