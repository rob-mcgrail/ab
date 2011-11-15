# Over-riding a warning about #options being deprecated.
#
# Some library is calling #options still. 
# Check some time in the future that this is
# still the case.

class Sinatra::Base
  def options
    settings
  end
end
