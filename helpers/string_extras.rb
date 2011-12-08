# Helpers added to String

class String
  def parameterize
    self.gsub(/[^a-z0-9\-_!?]+/i, '-').downcase
  end

  def to_hash
    BCrypt::Password.create(self)
  end

  def make_matchable
    BCrypt::Password.new(self)
  end
  
  def url_trim(i, delimeter = '...')
    if self.length > i
      x = (self.length/2).to_i
      first = self[0, (i/2)-1]
      second = self[(x/2), self.length]
      second = self[(self.length - (i/2).to_i), self.length]
      first + delimeter + second
    else
      self
    end
  end
end
