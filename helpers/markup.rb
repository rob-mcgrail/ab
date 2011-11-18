helpers do
  def winner_class(k)
    if @winner
      'winner' if @winner.k == k
    else
      nil
    end
  end
end
