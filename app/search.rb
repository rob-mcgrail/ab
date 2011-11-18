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
        File.open(file_name, 'w') {|f| f.write "DATE, IP, QUERY_TERM, A, B, WINNER, LOSER, SCORE\n"}
      end
      File.open(file_name, 'a+') do |f|
        f.write "#{self.created_at}, #{self.ip}, #{self.query_term}, #{self.a}, #{self.b}, #{self.winner}, #{self.loser}, #{self.win_score}\n"
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
  q = injest_query(params[:query_term])
  handlers = Handler.any_two_safely
  @results = ab_search(handlers, q)
  @search = Search.new(
    :query_term =>  q,
    :ip =>          @env['REMOTE_ADDR'],
    :a =>           handlers[:a].id,
    :b =>           handlers[:b].id,
    :created_at =>  Time.now
  )
  if @search.save
    flash[:success] = success_text[:search_for]
    redirect "/search/#{@search.id}"
  else
    flash[:error] = error_text[:cant_save]
    redirect '/'
  end
end


post '/compare/rank?' do
  handlers = Handler.get_pair_safely(params[:a], params[:b])
  handlers.assign_points params[:winner], :score => params[:score]
  @search = Search.first(:id => params[:search_id])
  @search.attributes = {
    :winner => params[:winner].to_i,
    :loser => params[:loser].to_i,
    :win_score => @search.win_score + params[:score].to_i,
  }
  if @search.save
    @search.log
    flash[:success] = success_text[:ranked]
    redirect '/'
  else
    flash[:error] = error_text[:cant_save]
    redirect '/'
  end
end


get '/search/:id?' do
  @search = Search.first(:id => params[:id])
  if @search == nil
    flash[:error] = error_text[:search_not_found]
    redirect '/'    
  end
  q = injest_query(@search.query_term)
  handlers = Handler.get_pair_safely(@search.a, @search.b)
  if @search.winner
    @winner = handlers.get @search.winner
    @loser = handlers.get @search.loser
  end
  @results = ab_search(handlers, q)
  haml :'results/main'
end


get '/search?' do
  flash[:error] = error_text[:forbidden]
  redirect '/'
end



get '/compare?' do
  haml :'search/compare'
end























