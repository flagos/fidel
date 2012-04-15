class Order
  include DataMapper::Resource
  
  belongs_to :client

  property :id,        Serial
  property :sum,      Integer, :required => true

end


get '/orders/:client' do
  erb :view_order

end

get '/orders/:client/add' do
  erb :add_order
end
