require 'spec_helper'
require 'method_missing/ap_method'
require 'method_missing/method_extension'

describe ApMethod do
  def add3_m(x)
    x + 3
  end
  def mul2_m(x)
    x * 2
  end
  def sub1_m(x)
    x - 1
  end
  def div4_m(x)
    x / 4
  end

  let(:sub1) { method(:sub1_m) }
  let(:mul2) { method(:mul2_m) }
  let(:add3) { method(:add3_m) }
  let(:div4) { method(:div4_m) }

  subject { ApMethod.new([sub1, mul2, div4]) }

  it "composes" do
    (subject * add3).call(4).should ==
      [sub1.call(add3.call(4)),
        mul2.call(add3.call(4)),
        div4.call(add3.call(4))]
  end

  it "sequences" do
    result = [sub1.call(4), mul2.call(4), div4.call(4), add3.call(4)]
    (subject / add3).call(4).should == result
  end

  it "repeats" do
    power = 3
    argument = 4
    result = [
      (sub1 ^ power).call(argument),
      (mul2 ^ power).call(argument),
      (div4 ^ power).call(argument)]
    (subject ^ power).call(argument).should == result
  end

  context 'the Method interface' do
    it "is callable" do
      subject.call(4).should == [sub1.call(4), mul2.call(4), div4.call(4)]
    end

    it "has #[] as an alias for #call" do
      subject[4].should == [sub1.call(4), mul2.call(4), div4.call(4)]
    end

    it "knows the arity of the method" do
      subject.arity.should == 1
    end

    it "inspects into something nice" do
      expected = "#<ApMethod: #{sub1.inspect} / #{mul2.inspect} / #{div4.inspect}>"
      subject.inspect.should == expected
    end

    it "converts itself to a Proc" do
      subject.to_proc.should be_a(Proc)
      subject.to_proc.call(4).should == [sub1.call(4), mul2.call(4), div4.call(4)]
    end

    it "is unable to know the receiver" do
      expect { subject.receiver }.to raise_error
    end

    it "is unable to know the method owner" do
      expect { subject.owner }.to raise_error
    end

    it "is unable to know its name" do
      expect { subject.name }.to raise_error
    end

    it "is unable to unbind" do
      expect { subject.unbind }.to raise_error
    end
  end
end
