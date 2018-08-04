class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.length == 0
        resp.write "Your cart is empty"
      else
        @@cart.each do |cart|
          resp.write "#{cart}\n"
        end
    end
  elsif req.path.match(/add/)
    add_to_cart = req.params["item"]
    resp.write handle_add(add_to_cart)
  else
    resp.write "Path Not Found"
  end

    resp.finish
  end

  def handle_add(add_to_cart)
    if @@items.include?(add_to_cart)
      @@cart << add_to_cart
      return "added #{add_to_cart}"
    # elsif
    #   @@cart << add_to_cart
    #   resp.write "Added #{add_to_cart}"
    else
      return "We don't have that item!"
    end
end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      @@items << search_term
      return "Added #{search_term}"
    end
  end
end
