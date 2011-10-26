require 'spec_helper'
require 'method_missing/cons_method'

describe ConsMethod do
  def add3_m(x)
    x + 3
  end
  def mul2_m(x)
    x * 2
  end
  def sub1_m(x)
    x - 1
  end

  let(:sub1) { method(:sub1_m) }
  let(:mul2) { method(:mul2_m) }
  let(:add3) { method(:add3_m) }

  subject { ConsMethod.new(sub1, mul2) }

  it "composes" do
    (subject * add3).call(4).should == sub1.call(mul2.call(add3.call(4)))
  end

  it "sequences" do
    (subject / add3).call(4).should == [sub1.call(4), mul2.call(4), add3.call(4)]
  end

  it "repeats" do
    result = sub1.call(mul2.call(
      sub1.call(mul2.call(
        sub1.call(mul2.call(4))))))
    (subject ^ 3).call(4).should == result
  end

  context 'the Method interface' do
    it "is callable" do
      subject.call(4).should == sub1.call(mul2.call(4))
    end

    it "has #[] as an alias for #call" do
      subject[4].should == sub1.call(mul2.call(4))
    end

    it "knows the arity of the method" do
      subject.arity.should == 1
    end

    it "inspects into something nice" do
      expected = "#<ConsMethod: #{sub1.inspect} * #{mul2.inspect}>"
      subject.inspect.should == expected
    end

    it "converts itself to a Proc" do
      subject.to_proc.should be_a(Proc)
      subject.to_proc.call(4).should == sub1.call(mul2.call(4))
    end

    it "knows the receiver" do
      subject.receiver.inspect.should == mul2.receiver.inspect
    end

    it "knows the method owner" do
      subject.owner.should == mul2.owner
    end

    it "is unable to know its name" do
      expect { subject.name }.to raise_error
    end

    it "is unable to unbind" do
      expect { subject.unbind }.to raise_error
    end
  end
end
