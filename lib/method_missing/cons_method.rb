require 'method_missing/ap_method'

class ConsMethod
  def initialize(f,g)
    @f = f
    @g = g
  end

  def *(h)
    ConsMethod.new(self, h)
  end

  def /(h)
    ApMethod.new([@f, @g, h])
  end

  def ^(n)
    if n < 2
      self
    else
      ConsMethod.new(self, self ^ (n-1))
    end
  end


  def owner
    @g.owner
  end

  def receiver
    @g.receiver
  end

  def to_proc
    Proc.new {|x| @f.call(*@g.call(*x)) }
  end

  def inspect
    "#<ConsMethod: #{@f.inspect} * #{@g.inspect}>"
  end

  def arity
    @g.arity
  end

  def call(x)
    @f.call(*@g.call(*x))
  end

  def [](*x)
    call(*x)
  end
end
