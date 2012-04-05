class Pricing
  include DataMapper::Resource
  
  belongs_to :client

  property :id,        Serial
  property :is_used,   Boolean, :required => true, :default => false

end
