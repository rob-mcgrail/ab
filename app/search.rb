# http://datamapper.org/docs/properties.html
# Note default validations in settings.rb

class Search
  include DataMapper::Resource

  property :id,           Serial
  property :query_term,   String
  property :ip,           String
  property :a,            Integer
  property :b,            Integer
  property :winner,       Integer,  :required => false
  property :loser,        Integer,  :required => false
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
  
  def ranked?
    if self.winner
      true
    else
      nil
    end
  end
end


helpers do
  def indentical?(results)
    return true if results.nil?
    i = 0; matches = 0; a = []
    results.each {|k,v| a << v[:items].length}
    match_length = a.min
    results[:a][:items].each do |v|
      unless results[:b][:items][i].nil?
        if v.pid == results[:b][:items][i].pid && v.pid != nil
          matches += 1
        end
      end
      i += 1
    end
    if matches == match_length
      true
    else
      nil
    end
  end

  
  def injest_query(q)
    if q == nil || q == '' || q == misc_text[:search_box]
      flash[:error] = error_text[:no_query]
      redirect '/'
    end
    q
  end
end


get '/?' do
  haml :'search/main'
end


get '/search/:id/?' do
  @search = Search.first(:id => params[:id])
  if @search == nil
    flash[:error] = error_text[:search_not_found]
    redirect '/'    
  end
  q = injest_query(@search.query_term)
  handlers = Handler.get_pair(@search.a, @search.b)
  if handlers == nil
    flash[:error] = error_text[:missing_handler]
    redirect '/'
  end  
  if @search.ranked?
    @winner = handlers.get @search.winner
    @loser = handlers.get @search.loser
  end
  @results = Solr.ab_search(q, handlers)
  haml :'results/main'
end


post '/compare/?' do
  q = injest_query(params[:query_term])
  depth = 0
  while indentical?(@results)
    depth += 1
    if depth >= settings.unique_attempts
      flash[:success] = error_text[:no_differences]
      redirect '/'    
    elsif depth >= 3 && @results[:a][:items].length <= 1
      flash[:success] = error_text[:no_differences]
      redirect '/'      
    else
      handlers = Handler.any_two
      if handlers == nil
        flash[:success] = error_text[:no_handlers]
        redirect '/'
      end
      @results = Solr.ab_search(q, handlers)
    end
  end
  @search = Search.new(
    :query_term =>  q,
    :ip =>          @env['REMOTE_ADDR'],
    :a =>           handlers[:a].id,
    :b =>           handlers[:b].id,
    :created_at =>  Time.now
  )
  if @search.save
    redirect "/search/#{@search.id}"
  else
    flash[:error] = error_text[:cant_save]
    redirect '/'
  end
end


post '/compare/rank/?' do
  handlers = Handler.get_pair(params[:a], params[:b])
  if handlers == nil
    flash[:error] = error_text[:missing_handler]
    redirect '/'
  end
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


get '/search/?' do
  flash[:error] = error_text[:forbidden]
  redirect '/'
end



