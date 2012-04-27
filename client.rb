
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


get '/clients.json' do

  json=Hash.new
  json["metadata"] = [{ :name     => "name",
                        :label    => "Name",
                        :datatype => "string",
                        :editable => true },
                      { :name     => "surname",
                        :label    => "Surname",
                        :datatype => "string",
                        :editable => true },
                      { :name     => "birth",
                        :label    => "Birth",
                        :datatype => "date",
                        :editable => true },
                      { :name     => "email",
                        :label    => "Email",
                        :datatype => "email",
                        :editable => true },
                      { :name     => "page",
                        :label    => "Page",
                        :datatype => "html",
                        :editable => false },
                                            
    ]
  json["data"] = Array.new
  Client.all.each do |c|
    json["data"].push( { :id      => c.id,
                         :values  => {
                           :name    => c.name,
                           :surname => c.surname,
                           :birth   => c.birth.nil? ? "" : c.birth.strftime('%d/%m/%y'),
                           :email   => c.email,
                           :page    => "<a href=\"/client/#{c.id}\"> Consulter </a>" ,
                         }
                       }
                     )
  end
  json.to_json
end

get '/client/new' do
  erb :create_client
end

post '/client/new' do
  @client = Client.create(:name    => params[:name],
                          :surname => params[:surname],
                          :email   => params[:email],
                          :birth   => params[:birth])
  erb :register_client  
end


get '/client/:client_id' do
  @c = Client.get(params[:client_id])
  erb :view_client
end
