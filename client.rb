
class Client
  include DataMapper::Resource
  
  has n, :orders

  property :id,        Serial
  property :name,      String, :required => true
  property :surname,   String, :required => true
  property :birth,     DateTime
  property :email,     String, :format => :email_address

end

get '/clients' do
  erb :view_clients
end

get '/client/new' do
  erb :create_client
end

get '/client/:client_id' do
  @c = Client.get(params[:client_id])
  puts @c
  erb :view_client
end

post '/client/new' do
  @client = Client.create(:name   => params[:name],
                         :surname => params[:surname],
                         :email   => params[:email],
                         :birth   => params[:birth])
  erb :register_client  
end
