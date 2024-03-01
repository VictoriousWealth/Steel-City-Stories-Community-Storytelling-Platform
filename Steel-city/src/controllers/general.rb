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

post "/login" do
    @username = params.fetch("username", "")
    @password = params.fetch("password", "")
    @error = nil
    entered_password=User.first(username: @username).password
    entered_password = entered_password.to_s
    if @Password==entered_password
      session["logged_in"] = true
      redirect "/"
    else
      @error = "Username/Password combination incorrect - #{entered_password}"

    end
  
    erb :login_Page
end

get "/logout" do
    session.clear
    erb :logout
end
