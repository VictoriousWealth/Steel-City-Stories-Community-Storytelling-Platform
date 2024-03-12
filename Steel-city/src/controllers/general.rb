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

#get "/create-account"
#    erb :create-account
#end

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
    @email = params.fetch("email","")
    @account_type = params.fetch("account_type","")
    check_username = User.first(username: @username).username
    if @password!=@confirm_password
      @error="Passwords do not match"
    elsif check_username!.empty?
      @error="Username already in use"
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
    entered_password=User.first(username: @username).password
    entered_password = entered_password.to_s
    if @password==entered_password
      session["logged_in"] = true
      @type=User.first(username: @username).type

      redirect "/"
    else
    @error = "Username/Password combination incorrect - #{entered_password} - #{@password}"
    end
  
    erb :login_Page
end

get "/logout" do
    session.clear
    erb :logout
end
