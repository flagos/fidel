class Order
  include DataMapper::Resource
  
  belongs_to :client

  property :id,       Serial
  property :sum,      Integer, :required => true
  property :date,     DateTime

end


get '/orders/:client' do
  erb :view_order

end


get '/orders/:client_id/new' do
  @c = Client.get(params[:client_id])
  erb :create_order
end

post '/orders/:client_id/new' do
  @c = Client.get(params[:client_id])
  puts params.inspect
  @order = Order.create(:sum    => params[:sum],
                        :date   => Time.now,
                        :client => @c)
  erb :register_order
end
