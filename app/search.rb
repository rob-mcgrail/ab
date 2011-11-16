# http://datamapper.org/docs/properties.html
# Note default values in settings.rb

class Search
  include DataMapper::Resource

  property :id,           Serial
  property :query_term,   String
  property :ip,           String
  property :a,            String
  property :b,            String
  property :winner,       String,   :required => false
  property :loser,        String,   :required => false
  property :win_score,    Integer,  :required => false 
  property :created_at,   DateTime
  
  
  def log(file_name = settings.solr_log_file)
    begin
      unless File.exists? file_name
        File.open(file_name, w) {|f| f.write 'DATE, QUERY_TERM, A, B, WINNER, LOSER, SCORE'}
      end
      File.open(file_name, 'a+') do |f|
        f.write "#{self.created_at}, \
        #{self.query_term}, \
        #{self.a}, \
        #{self.b}, \
        #{self.winner}, \
        #{self.loser}, \
        #{self.win_score}"
      end
    rescue Exception => e
      puts e
    end
  end
end


get '/?' do
  haml :'search/main'
end


post '/compare?' do
  q = params[:query_term]
  handlers = Handlers.any_two
  handler_check handlers
  @results = []
  handlers.each do |k,v|
    #the search
    @results << {:handler => 'placeholder', :results => [1,2,3,4,5]} #dummy content
  end
  @search = Search.new(
    :query =>     q,
    :ip =>        @env['REMOTE_ADDR'],
    :a =>         handlers[:a],
    :b =>         handlers[:b],
    :created_at => Time.now
  )
  if @search.save
    haml :'search/results'
  else
    flash[:error] = error_text[:generic]
    redirect '/'
  end
end


get '/compare?' do
  flash[:error] = error_text[:forbidden]
  redirect '/'
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























