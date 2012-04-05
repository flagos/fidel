class Order
  include DataMapper::Resource
  
  belongs_to :client

  property :id,        Serial
  property :sum,      Integer, :required => true

end
