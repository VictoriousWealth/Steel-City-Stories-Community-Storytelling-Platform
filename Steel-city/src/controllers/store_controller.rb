require "require_all"

get "/store" do
    @myTitle = "Store"
    @items = session["items"]
    erb :store
end

get "/payment" do
    @myTitle = "Checkout"
    erb :payment_page
end

post "/additem" do
    session["items"] += 1
    @items = session["items"]
    erb :store
end