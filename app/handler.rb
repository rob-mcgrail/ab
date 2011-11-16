# http://datamapper.org/docs/properties.html
# Note default validations in settings.rb

class Handler
  include DataMapper::Resource

  property :id,               Serial
  property :name,             String,   :unique => true
  property :request,          String
  property :positive,         Integer,  :default => 0
  property :negative,         Integer,  :default => 0
  property :ranked_searches,  Integer,  :default => 0
  property :created_at,       DateTime
  
  def won(i)
    self.attributes = {
      :positive => self.positive + i.to_i, 
      :ranked_searches => self.ranked_searches + 1
    }
  end
  
  
  def lost
    self.attributes = {
      :negative => self.negative + 1, 
      :ranked_searches => self.ranked_searches + 1
    }
  end
end
