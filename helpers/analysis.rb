helpers do
  def winner_class(k)
    if @winner
      'winner' if @winner.k == k
    else
      nil
    end
  end
  
  
  def percent(a, b)
    ratio = b.to_f / a.to_f * 100
    if ratio.nan?
      '0%'
    else
      "#{ratio.to_i}%"
    end
  end
  

  def search_outcome(search, handler_id)
    if search.winner
      if search.winner == handler_id
        'Won'
      elsif search.loser == handler_id
        'Lost'
      end
    else
    'Unranked'
    end
  end
  
  
  def get_opponent(search, handler_id) #redo all the db, and see if the to_i still necessary
    if search.winner == handler_id
      handler = Handler.first(:id => search.loser)
    elsif search.loser == handler_id
      handler = Handler.first(:id => search.winner)
    else
      if search.a == handler_id
        handler = Handler.first(:id => search.b)
      elsif search.b == handler_id
        handler = Handler.first(:id => search.a)
      else
         flash[:error] = error_text[:generic]
         redirect '/'
      end
    end
    handler.name
  end
end
