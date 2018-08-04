class Application
  @@cart = []
  @@items = %w[Apples Carrots Pears]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    if req.path =~ /items/
      @@items.each { |item| resp.write "#{item}\n" }
    elsif req.path =~ /search/
      search = req.params['q']
      resp.write @@items.include?(search) ? "#{search} is one of our items" : "Couldn't find #{search}"
    elsif req.path =~ /cart/
      resp.write @@cart.empty? ? 'Your cart is empty' : @@cart.join("\n")
    elsif req.path =~ /add/
      item = req.params['item']
      @@cart << item if (x = @@items.include?(item))
      resp.write x ? "added #{item}" : "We don't have that item!"
    else
      resp.write 'Path Not Found'
    end

    resp.finish
  end
end
