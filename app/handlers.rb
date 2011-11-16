class Handlers
  def self.any_two
    h = {}
    a = Handler.all
    a.shuffle
    h[:a] = a.pop.name
    h[:b] = a.pop.name
    
    if h.has_value? nil
      nil
    else
      h
    end
  end
  
  def self.any_two_safely
    h = Handlers.any_two
    if h == nil
      flash[:error] = error_text[:no_handlers]
      redirect '/'
    else
      h
    end
  end
  
  
  def self.get(name)
    h = Handler.first(:name => name)
  end
end
