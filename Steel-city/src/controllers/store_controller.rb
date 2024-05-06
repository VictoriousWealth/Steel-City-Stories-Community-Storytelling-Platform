require "require_all"

get "/store" do
    @myTitle = "Store"
    erb :store
end

get "/payment" do
    ITEM_PRICES = {
      '1000 Popcorns' => 4.99,
      '2000 Popcorns' => 8.99,
      '5000 Popcorns' => 14.99,
      '1 Month Subscription' => 9.99,
      '3 Month Subscription' => 19.99,
      '1 Year Subscription' => 39.99
    }
    @total = 0
    @cart = session["cart"] 
    @cart.each do |item, quantity|
      price = ITEM_PRICES[item] || 0  # Default to 0 if item not found in prices
      @total += price * quantity
    end
    @total
    @myTitle = "Checkout"
    erb :payment_page
end

post "/additem/:item" do
    if session["cart"].key?(params[:item])
      session["cart"][params[:item]] += 1
    else
      session["cart"][params[:item]] = 1
    end
    erb :store
end

post "/buyitemsincart" do
    session["cart"].each do |item, quantity|
      session["cart"].delete(item)
    end
    erb :payment_page
end