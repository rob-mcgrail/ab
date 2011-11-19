class HandlerPair < Hash
  def assign_points(winner, opts = {})
    i = opts[:score] || 1
    if self[:a].id == winner.to_i
      self[:a].won(i)
      self[:b].lost
    else
      self[:b].won(i)
      self[:a].lost
    end
    self.each_value do |v|
      unless v.save
        flash[:error] = error_text[:cant_save]
        redirect '/'        
      end
    end
  end
  
  
  def get(id)
    x = nil
    self.each do |k,v|
      if v.id == id.to_i
        v.k = k
        x = v
      end
    end
    x
  end
end
