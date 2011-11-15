# http://datamapper.org/docs/properties.html
# Note default values in settings.rb

class Handler
  include DataMapper::Resource

  property :id,           Serial
  property :score,        Integer,  :required => false
  property :searches,     Integer,  :required => false
  property :scored,       Integer,  :required => false
  property :handler,      String
end
