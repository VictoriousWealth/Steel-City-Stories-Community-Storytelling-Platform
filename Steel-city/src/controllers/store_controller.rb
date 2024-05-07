require "require_all"

get "/store" do
    @myTitle = "Store"
    session["totalprice"] = 0.0
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
    @compounds = User.first(userid: session["currentuser"]).compounds
    @total = 0.0
    @cart = session["cart"] 
    @cart.each do |item, quantity|
      price = ITEM_PRICES[item] || 0  # Default to 0 if item not found in prices
      @total += price * quantity
    end
    session["totalprice"] = @total
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
    user = User.first(userid: session["currentuser"])

    if user.nil? #|| user.compounds.nil?
      return erb :payment_page
    end

    if session["totalprice"] > user.compounds
      return erb :store
    else
      user.update(compounds: user[:compounds] - session["totalprice"])
    end

    session["totalprice"] = 0
    session["cart"] = {}
    @total = session["totalprice"]
    @myTitle = "Checkout"
    @cart = session["cart"]
    @compounds = user.compounds
    erb :payment_page
end

post "/removeitem/:item" do
    item = params[:item]
    if session["cart"][item] > 1
      session["cart"][item] -= 1
    else
      session["cart"].delete(item)
    end
    @total = session["totalprice"]
    @myTitle = "Checkout"
    @cart = session["cart"]
    @compounds = User.first(userid: session["currentuser"]).compounds
    erb :payment_page
end