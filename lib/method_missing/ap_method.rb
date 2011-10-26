require 'method_missing/cons_method'

class ApMethod
  def initialize(methods)
    @methods = methods
  end

  def *(f)
    ApMethod.new(@methods.map {|m| ConsMethod.new(m, f)})
  end

  def /(f)
    ApMethod.new(@methods + [f])
  end

  def ^(power)
    ApMethod.new(@methods.map {|m| m ^ power})
  end


  def call(*x)
    @methods.map{|m| m.call(*x)}
  end

  def to_proc
    lambda {|*x|
      @methods.map {|m| m.call(*x) }
    }
  end

  def inspect
    "#<ApMethod: #{@methods.map{|m| m.inspect}.join(' / ')}>"
  end

  def arity
    @methods.first.arity
  end

  def [](*x)
    call(*x)
  end
end
