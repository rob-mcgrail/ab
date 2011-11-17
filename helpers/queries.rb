helpers do
  def injest_query(q)
    if q == nil || q == ''
      flash[:error] = error_text[:no_query]
      redirect '/'
    end
    q
  end


  def ab_search(h, q)
    results = []
    h.each do |k,v|
      #the search
      results << {:handler => v.id, :items => [1,2,3,4,k]} #dummy content
    end
    results
  end
end
