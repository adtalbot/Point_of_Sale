require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('./lib/product')
require('./lib/purchase')
require('pry')

get('/') do
  @products = Product.all()
  erb(:index)
end

post('/') do
  name = params.fetch("name")
  price = params.fetch("price").to_f
  Product.create({:name => name, :price => price})
  @products = Product.all()
  erb(:index)
end

get('/products/:id') do
  id = params.fetch("id").to_i
  @product = Product.find(id)
  @purchases = Purchase.all()
  erb(:product_info)
end

patch('/products/:id') do
  id = params.fetch("id").to_i
  @product = Product.find(id)
  params.fetch("name") != "" ? name = params.fetch("name") : name = @product.name
  params.fetch("price") != "" ? price = params.fetch("price") : price = @product.price
  purchase_ids = params.fetch("purchase_ids")
  purchase_ids.each() do |id|
    purchase = Purchase.find(id.to_i)
    purchase.update({:product_ids => [@product.id]})
  end
  @product.update({:name => name, :price => price})
  @purchases = Purchase.all()

  erb(:product_info)
end

delete('/products/:id') do
  id = params.fetch("id").to_i
  @product = Product.find(id)
  @product.delete()
  @products = Product.all()
  erb(:index)
end

get('/purchases') do
  @available_products = Product.all
  erb(:purchases)
end

patch('/purchases') do
  new_purchase = Purchase.create()
  product_ids = params.fetch("product_ids")
  product_ids.each() do |id|
    id = id.to_i()
    product = Product.find(id)
    product.update({:purchase_ids => [new_purchase.id]})
  end
  @total = 0.0
  @purchased_products = []
  erb(:purchase_info)
end

get('/reports') do
  @purchases = []
  erb(:reports)
end

post('/reports') do
  start_date = params.fetch("start_date")
  end_date = params.fetch("end_date")
  @purchases = Purchase.between(start_date, end_date)
  erb(:reports)
end

get('/purchases/:id') do
  id = params.fetch('id').to_i
  purchase = Purchase.find(id)
  @purchased_products = purchase.products()
  @total = 0.0
  erb(:purchase_info)
end

patch('/products/:id/return') do
  id = params.fetch("id").to_i
  @product = Product.find(id)
  @product.update({:purchase_id => nil})
  erb(:product_info)
end
