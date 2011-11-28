# http://datamapper.org/docs/properties.html
# Note default validations in settings.rb

class Handler
  include DataMapper::Resource
  attr_accessor :k # for storing a handler instance's position
                   # in the HandlerPair hash

  property :id,               Serial
  property :name,             String,   :unique => true
  property :request,          String
  property :score,            Integer,  :default => 0
  property :positive,         Integer,  :default => 0
  property :negative,         Integer,  :default => 0
  property :ranked_searches,  Integer,  :default => 0
  property :active,           Boolean,  :default => true
  property :created_at,       DateTime
  
    
  def won(i = 1)
    self.attributes = {
      :score => self.score + i.to_i,
      :positive => self.positive + 1,
      :ranked_searches => self.ranked_searches + 1
    }
  end
  
  
  def lost(i = 1)
    self.attributes = {
      :negative => self.negative + 1,
      :ranked_searches => self.ranked_searches + 1
    }
  end
  
  
  def self.any_two
    h = HandlerPair.new
    a = Handler.all(:active => true)
    a.shuffle!
    h[:a] = a.pop
    h[:b] = a.pop
    if h.has_value? nil
      nil
    else
      h
    end
  end


  def self.any_two_safely
    h = Handler.any_two
    if h == nil
      flash[:error] = error_text[:no_handlers]
      redirect '/'
    else
      h
    end
  end
  
  
  def self.get_pair(a, b)
    h = HandlerPair.new
    h[:a] = Handler.first(:id => a)
    h[:b] = Handler.first(:id => b)
    if h.has_value? nil
      nil
    else
      h
    end
  end
  
  
  def self.get_pair_safely(a, b)
    h = Handler.get_pair(a, b)
    if h == nil
      flash[:error] = error_text[:missing_handler]
      redirect '/'
    else
      h
    end
  end

  
  def self.get_id_by_name(handler_name)
    Handler.first(:name => handler_name).id
  end
  
  
  def valid_request?
    begin
      puts Solr.search('education', :handler => self.request)
    rescue OpenURI::HTTPError
      nil
    else
      true
    end
  end
end

#
# May just delete if run out of time
#

get '/handlers/?' do
  @active_handlers = Handler.all(:active => true)
  @inactive_handlers = Handler.all(:active => false)
  @active_handlers.sort! {|x,y| y.score <=> x.score }
  haml :'handlers/list'
end


get '/handler/:handler_id/?' do
  @handler = Handler.first(:id => params[:handler_id])
  @searches = Search.all(:a => @handler.id) + Search.all(:b => @handler.id)
  haml :'handlers/inspect'
end



get '/handlers/admin/?' do
  @active_handlers = Handler.all(:active => true)
  @inactive_handlers = Handler.all(:active => false)
  haml :'handlers/admin'
end


post '/handler/:handler_id/state_change/?' do
  @handler = Handler.first(:id => params[:handler_id])
  @state = params[:state]
  if @state == 'active'
    @handler.active = true
  elsif @state == 'inactive'
    @active_handlers = Handler.all(:active => true)
    if @active_handlers.length < 3
      flash[:error] = error_text[:need_handlers]
      redirect '/handlers/admin'
    else
      @handler.active = false
    end
  else
    flash[:error] = error_text[:generic]
    redirect '/handlers/admin'
  end
  if @handler.save
    flash[:success] = success_text[:handler_state_changed]
    redirect '/handlers/admin'
  else
    flash[:error] = error_text[:cant_save]
    redirect '/handlers/admin'
  end
end


get '/handlers/admin/new/?' do
  haml :'handlers/new'
end


post '/handlers/admin/new/?' do
  @handler = Handler.new(
    :name =>    params[:name],
    :request => params[:request],
    :created_at =>  Time.now
  )
  unless @handler.valid_request?
    flash[:success] = error_text[:invalid_handler]
    redirect '/handlers/admin'
  end
  if @handler.save
    flash[:success] = success_text[:new_handler]
    redirect '/handlers/admin'
  else
    flash[:error] = error_text[:cant_save]
    redirect '/handlers/admin/new'
  end  
end






