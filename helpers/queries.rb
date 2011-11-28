helpers do
  def injest_query(q)
    if q == nil || q == '' || q == misc_text[:search_box]
      flash[:error] = error_text[:no_query]
      redirect '/'
    end
    q
  end
end
