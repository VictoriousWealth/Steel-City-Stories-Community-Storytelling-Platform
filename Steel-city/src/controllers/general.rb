
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
  
    if @username == "user" && @password == "pass"
      session["logged_in"] = true
      redirect "/"
    else
      @error = "Username/Password combination incorrect"
    end
  
    erb :login
end

get "/logout" do
    session.clear
    erb :logout
end
