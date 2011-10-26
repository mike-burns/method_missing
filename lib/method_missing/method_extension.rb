require 'method_missing/cons_method'
require 'method_missing/ap_method'

class Method
  def *(g)
    ConsMethod.new(self,g)
  end

  def /(g)
    ApMethod.new([self, g])
  end

  def ^(power)
    if power < 2
      self
    else
      ConsMethod.new(self, self ^ (power-1))
    end
  end
end
