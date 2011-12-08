helpers do
  def error_text
    {
      :forbidden => 'You can\'t do that. How about a search?',
      :generic => 'An error has occured',
      :search_not_found => 'You requested a previous search that doesn\'t exist!',
      :no_handlers => 'Serious error: Search handlers not found!',
      :missing_handler => 'Couldn\'t find something we need!',
      :cant_save => 'Something went serious wrong!',
      :no_query => 'You need to enter a search term!',
      :need_handlers => 'You need at least two handlers!',
      :invalid_handler => 'The handler you tried to create had invalid parameters!',
      :invalid_password => 'Sorry, that\'s not the password',
      :needs_password => 'Sorry, only administrators can see that...',
      :no_differences => 'We tried that search in a bunch of combinations, and the results were always the same! Can you try again?'
    }
  end
  
  
  def success_text
    ##############
    # Unimaginable horribleness, to be fixed.
    require 'ostruct'
    @search = OpenStruct.new unless @search
    @handler = OpenStruct.new unless @handler
    @state = '' unless @state
    ##############
    
    {
      :ranked => "Thanks. Your vote has been saved. Retrieve your search @ #{link_to uri("search/#{@search.id}", true), "search/#{@search.id}", :class => 'success'}",
      :search_for => "Results for #{safe @search.query_term}",
      :handler_state_changed => "#{@handler.name} changed to #{@state}.",
      :new_handler => "#{@handler.name} created.",
      :logged_out => 'You are now logged out.',
      :logged_in => 'You are now logged in'
    }
  end
  
  
  def misc_text
    {
      :search_box => 'Search...',
      :outcome_won => 'Won',
      :outcome_lost => 'Lost',
      :outcome_unranked => 'Unranked',
    }
  end
end
