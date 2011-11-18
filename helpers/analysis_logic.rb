helpers do
  def search_outcome(search, handler_id)
    if search.winner
      if search.winner.to_i == handler_id
        'Won'
      elsif search.loser.to_i == handler_id
        'Lost'
      end
    else
    'Unranked'
    end
  end
  
  
  def get_opponent(search, handler_id) #redo all the db, and see if the to_i still necessary
    if search.winner.to_i == handler_id
      handler = Handler.first(:id => search.loser.to_i)
    elsif search.loser.to_i == handler_id
      handler = Handler.first(:id => search.winner.to_i)
    else
      if search.a.to_i == handler_id
        handler = Handler.first(:id => search.b.to_i)
      elsif search.b.to_i == handler_id
        handler = Handler.first(:id => search.a.to_i)
      else
         flash[:error] = error_text[:generic]
        redirect '/'
      end
    end
    handler.name
  end
  
  
  def get_handler_id(handler_name)
    Handler.first(:name => handler_name).id
  end
end
