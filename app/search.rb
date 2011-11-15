# http://datamapper.org/docs/properties.html
# Note default values in settings.rb

class Search
  include DataMapper::Resource

  property :id,           Serial
  property :query_term,   String
  property :handler_a,    String
  property :handler_b,    String
  property :winner,       String,   :required => false
  property :score,        Integer,  :required => false 
  property :created_at,   DateTime
end


get '/?' do
  # create authenticity token?

  haml :'search/main'
end


post '/compare?' do
  haml :'search/results'
  
  
  # create search
  # create authneticity token?
  # pass info from here in to hidden fields
  # do searches
  # select which div for which
  
end


get '/compare?' do

  #redirect to home with a warning
end


post '/compare/rank?' do

  # update search
  # log results
end


get '/search/:id?' do


end


get '/search/:id/explain?' do

end


get '/compare/:handler_a/:handler_b?' do

end























