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
    }
  end
  
  def success_text
    {
      :ranked => "Thanks. Your vote has been saved. Retrieve your search @ #{link_to uri("search/#{@search.id}", true), "search/#{@search.id}"}",
      :search_for => "Results for #{safe @search.query_term}"
    }
  end
end
