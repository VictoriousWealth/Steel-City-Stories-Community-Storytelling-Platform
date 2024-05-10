require "require_all"

get "/store" do
    @myTitle = "Store"
    session["totalprice"] = 0.0
    ITEM_PRICES = {
      '1000 Popcorns' => 4.99,
      '2000 Popcorns' => 8.99,
      '5000 Popcorns' => 14.99,
      '1 Month Subscription' => 9.99,
      '3 Month Subscription' => 19.99,
      '12 Month Subscription' => 39.99
    }
    PREMIUM = {
      '1 Month Subscription' => 30,
      '3 Month Subscription' => 90,
      '12 Month Subscription' => 365
    }
    POPCORNS = {
      '1000 Popcorns' => 1000,
      '2000 Popcorns' => 2000,
      '5000 Popcorns' => 5000
    }
    erb :store
end

get "/payment" do
  user = User.first(userid: session["currentuser"])
  if session && session["currentuser"]
    @compounds = user.compounds
    @total = 0.0
    @cart = session["cart"] 
    @cart.each do |item, quantity|
      price = ITEM_PRICES[item] || 0
      @total += price * quantity
    end
    session["totalprice"] = @total
  else
    @compounds = 0
    @total = 0
    @cart = {}
    session["totalprice"] = 0
  end
  @popcorns = user.popcorns
  @myTitle = "Checkout"
  erb :payment_page
end

get "/addcompounds" do
    @myTitle = "Add Compounds"
    erb :addcompounds_page
end

post "/additem/:item" do
    if session["cart"].key?(params[:item])
      session["cart"][params[:item]] += 1
    else
      session["cart"][params[:item]] = 1
    end
    @myTitle = "Store"
    erb :store
end

post "/buyitemsincart" do
    user = User.first(userid: session["currentuser"])
    @total = session["totalprice"]
    @myTitle = "Checkout"
    @cart = session["cart"]
    @compounds = user.compounds

    if user.nil? || user.compounds.nil?
      @error = "Cannot use staff account to buy Popcorns"
      return erb :payment_page
    end

    if session["totalprice"] > user.compounds
      @error = "Insufficient COM_pounds in your account"
      return erb :payment_page
    else
      user.update(compounds: user[:compounds] - session["totalprice"])
    end


    premium = PremiumSubscription.first(userid: session["currentuser"])
    if premium.nil?
      premium = PremiumSubscription.new
      premium.userid = session["currentuser"]
      premium.startdate = DateTime.now.to_s
      premium.length = '0'
    end

    premium_startdate = DateTime.parse(premium.startdate)

    if DateTime.now >= premium_startdate + premium.length.to_i
      premium.update(startdate: DateTime.now.to_s)
      premium.update(length: '0')
      premium_startdate = DateTime.parse(premium.startdate)
    end
    
    premium_length = premium.length.to_i

    @cart.each do |item, quantity|
      if POPCORNS.key?(item)
        user.update(popcorns: user[:popcorns] + POPCORNS[item])
      else
        premium_length += PREMIUM[item] * quantity
      end
    end


    if premium.nil? || premium_startdate + premium.length.to_i < DateTime.now
      user.update(premium: 0)
      user.update(activediscount: 1)
    else
      user.update(premium: 1)
      user.update(activediscount: 0.8)
    end


    premium.update(length: premium_length.to_s)
    session["totalprice"] = 0
    session["cart"] = {}
    @total = session["totalprice"]
    @myTitle = "Checkout"
    @cart = session["cart"]
    @compounds = user.compounds
    @premium = premium.length
    @popcorns = user.popcorns
    erb :payment_page
end

post "/removeitem/:item" do
    item = params[:item]
    if session["cart"][item] > 1
      session["cart"][item] -= 1
    else
      session["cart"].delete(item)
    end
    session["totalprice"] -= ITEM_PRICES[item]
    @total = session["totalprice"]
    @myTitle = "Checkout"
    @cart = session["cart"]
    @compounds = User.first(userid: session["currentuser"]).compounds
    erb :payment_page
end

post "/addcompoundstoaccount" do
    @myTitle = "Add Compounds"
    user = User.first(userid: session["currentuser"])

    if user.nil? || user.compounds.nil?
      @error = "Cannot use staff account to buy COM_pounds"
    else
      user.update(compounds: user[:compounds] + 100)
    end
    erb :addcompounds_page
end
