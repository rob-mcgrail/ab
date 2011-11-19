helpers do
  def percent(a, b)
    ratio = b.to_f / a.to_f * 100
    if ratio.nan?
      '0%'
    else
      "#{ratio.to_i}%"
    end
  end
end
