helpers do
  def handler_check(h)
    if h == nil
      flash[:error] = error_text[:no_handlers]
      redirect '/'
    end
  end
end
