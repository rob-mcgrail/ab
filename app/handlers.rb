class Handlers
  def self.any_two
    h = {}
    a = Handler.all
    a.shuffle
    h[:a] = a.pop
    h[:b] = a.pop
    if h.has_value? nil
      nil
    else
      h
    end
  end
  
  
  def self.get(name)
    h = Handler.first(:name => name)
  end
end
