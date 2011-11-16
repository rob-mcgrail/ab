# http://datamapper.org/docs/properties.html
# Note default validations in settings.rb

class Search
  include DataMapper::Resource

  property :id,           Serial
  property :query_term,   String
  property :ip,           String
  property :a,            String
  property :b,            String
  property :winner,       String,   :required => false
  property :loser,        String,   :required => false
  property :win_score,    Integer,  :default  => 0
  property :created_at,   DateTime
  
  
  def log(file_name = settings.solr_log_file)
    begin
      unless File.exists? file_name
        File.open(file_name, w) {|f| f.write 'DATE, IP, QUERY_TERM, A, B, WINNER, LOSER, SCORE'}
      end
      File.open(file_name, 'a+') do |f|
        f.write "#{self.created_at}, \
        #{@env['REMOTE_ADDR']}, \
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
  q = injest_query
  handlers = Handlers.any_two_safely
  @results = ab_search(handlers, q)
  @search = Search.new(
    :query_term =>  q,
    :ip =>          @env['REMOTE_ADDR'],
    :a =>           handlers[:a],
    :b =>           handlers[:b],
    :created_at =>  Time.now
  )
  if @search.save
    haml :'results/main'
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
  @a = Handler.first(:name => params[:a]) #error handling needed, also how does this gel with Handlers.get_two...
  @b = Handler.first(:name => params[:b])
  assign_handler_points
  @search = Search.first(:id => params[:search_id])
  @search.attributes = {
    :winner => params[:winner],
    :loser => loser(@a, @b),
    :win_score => @search.win_score + params[:score].to_i,
  }
  if @search.save
    @search.log
    flash[:success] = success_text[:ranked]
    redirect '/'
  else
    flash[:error] = error_text[:generic]
    redirect '/'
  end
end


get '/search/:id?' do
  @search = Search.first(:id => params[:id])
  handlers = Handlers.get_pair_safely(@search.a, @search.b)
  q = injest_query(@search.query_term)
  @results = ab_search(handlers, q)
  haml :'results/main'
end


get '/search/:id/explain?' do

end


get '/compare/:handler_a/:handler_b?' do

end























