class Order
  include DataMapper::Resource
  
  belongs_to :client

  property :id,          Serial
  property :sum,         Float, :required => true
  property :date,        DateTime
  property :is_discount, Boolean, :default  => false  

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
  @order = Order.create(:sum         => params[:sum],
                        :date        => Time.now,
                        :is_discount => (params[:is_discount]=="on"),
                        :client      => @c)
  erb :register_order
  if @order.saved?
    redirect "/client/#{@c.id}"
  end
end

post '/orders/:client_id/update' do
  order = Order.get(params[:id])
  order[Orders_metadata[params[:column].to_i][:name]] = params[:value]
  order.save
end
