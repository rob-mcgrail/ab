helpers do
  def error_text
    {
      :forbidden => 'You can\'t go there!',
      :generic => 'An error has occured',
      :no_handlers => 'Serious error: Search handlers not found!',
      :no_query => 'You need to enter a search term!',
    }
  end
end
