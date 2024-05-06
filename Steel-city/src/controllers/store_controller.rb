require "require_all"

get "/store" do
    @myTitle = "Store"
    erb :store
end

get "/payment" do
    @myTitle = "Checkout"
    @cart = session["cart"]
    @itemPrices = {
      '1000 Popcorns' => 4.99,
      '2000 Popcorns' => 8.99,
      '5000 Popcorns' => 14.99,
      '1 Month Membership' => 9.99,
      '3 Months Membership' => 19.99,
      '1 Year Membership' => 59.99
    }
    @total = 0
    @cart.each do |item, quantity|
      @price = @itemPrices[item] || 0
      @total += @price * quantity
    end
    erb :payment_page
end

post "/additem/:item" do
    item = params[:item]
    if session["cart"].key?(item)
      session["cart"][item] += 1
    else
      session["cart"][item] = 1
    end  
    erb :store
end