require 'spec_helper'
require 'method_missing'

describe Method do
  def sub1_m(x)
    x - 1
  end
  def mul2_m(x)
    x * 2
  end

  let(:sub1) { method(:sub1_m) }
  let(:mul2) { method(:mul2_m) }

  it "adds a composition operator to a method" do
    (sub1 * mul2).call(3).should == sub1.call(mul2.call(3))
  end

  it "adds a sequencing operator to a method" do
    (sub1 / mul2).call(3).should == [sub1.call(3), mul2.call(3)]
  end

  it "adds a repeat operator to a method" do
    (mul2 ^ 3).call(3).should == mul2.call(mul2.call(mul2.call(3)))
  end
end
