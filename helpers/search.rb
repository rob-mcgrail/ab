helpers do
  def injest_query(q = params[:query_term])
    if q == nil || q == ''
      flash[:error] = error_text[:no_query]
      redirect '/'
    end
    q
  end


  def ab_search(handlers, q)
    results = []
    handlers.each do |k,v|
      #the search
      results << {:handler => v, :items => [1,2,3,4,5]} #dummy content
    end
    results
  end
  
  
  def assign_handler_points
    winner = params[:winner]
    if @a.name == loser(@a, @b)
      @a.won(params[:score]); @b.lost
    else
      @b.won(params[:score]); @a.lost
    end
    
    unless @a.save
      flash[:error] = error_text[:generic] #make these raise exceptions instead?
      redirect '/'
    end
    
    unless @b.save
      flash[:error] = error_text[:generic] #make these raise exceptions instead?
      redirect '/'
    end
  end
  
  
  def loser(a,b)
    if a.name == params[:winner]
      b.name
    elsif b.name == params[:winner]
      a.name
    else
      flash[:error] = error_text[:generic] #make these raise exceptions instead?
      redirect '/'    
    end
  end
end
