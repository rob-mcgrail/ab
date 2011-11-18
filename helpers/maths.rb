helpers do
  def percent(a, b)
    ratio = b.to_f / a.to_f * 100
    "#{ratio.to_i}%"
  end
end
