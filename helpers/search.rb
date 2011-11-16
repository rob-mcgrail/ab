helpers do
  def handler_check(h)
    if h == nil
      flash[:error] = error_text[:no_handlers]
      redirect '/'
    end
  end
  
  def injest_query
    if params[:query_term] == nil || params[:query_term] == ''
      flash[:error] = error_text[:no_query]
      redirect '/'
    end
    params[:query_term]
  end
  
  def ab_search(handlers, q)
    results = []
    handlers.each do |k,v|
      #the search
      results << {:handler => v, :items => [1,2,3,4,5]} #dummy content
    end
    results
  end
end
