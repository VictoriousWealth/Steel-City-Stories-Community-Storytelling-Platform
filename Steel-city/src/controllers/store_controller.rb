require "require_all"

get "/store" do
    @myTitle = "Store"
    erb :store
end

get "/payment" do
    @myTitle = "Checkout"
    erb :paymentpage
end

