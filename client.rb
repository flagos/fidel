
class Client
  include DataMapper::Resource
  
  has n, :orders

  property :id,        Serial
  property :name,      String, :required => true
  property :surname,   String, :required => true
  property :birth,     DateTime
  property :email,     String

end
