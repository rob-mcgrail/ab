helpers do
  def error_text
    {
      :forbidden => 'You can\'t do that. How about a search?',
      :generic => 'An error has occured',
      :no_handlers => 'Serious error: Search handlers not found!',
      :missing_handler => 'Couldn\'t find something we need!',
      :no_query => 'You need to enter a search term!',
    }
  end
  
  def success_text
    {
      :ranked => "Thanks. Your vote has been saved. Retrieve your search @ #{link_to uri("search/#{@search.id}", true), "search/#{@search.id}"}"
    }
  end
end
