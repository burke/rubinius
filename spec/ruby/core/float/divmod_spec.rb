require File.dirname(__FILE__) + '/../../spec_helper'

describe "Float#divmod" do
  it "returns an [quotient, modulus] from dividing self by other" do
    values = 3.14.divmod(2)
    values[0].should == 1
    values[1].should be_close(1.14, TOLERANCE)
    values = 2.8284.divmod(3.1415)
    values[0].should == 0
    values[1].should be_close(2.8284, TOLERANCE)
    values = -1.0.divmod(bignum_value)
    values[0].should == -1
    values[1].should be_close(9223372036854775808.000, TOLERANCE)
  end

  # Behaviour established as correct in r23953
  it "raises a FloatDomainError if self is NaN" do
    lambda { nan_value.divmod(1) }.should raise_error(FloatDomainError)
  end

  # Behaviour established as correct in r23953
  it "raises a FloatDomainError if other is NaN" do
    lambda { 1.divmod(nan_value) }.should raise_error(FloatDomainError)
  end

  # Behaviour established as correct in r23953
  it "raises a FloatDomainError if self is Infinity" do
    lambda { infinity_value.divmod(1) }.should raise_error(FloatDomainError)
  end

  ruby_version_is ""..."1.9" do
    it "raises FloatDomainError if other is zero" do
      lambda { 1.0.divmod(0)   }.should raise_error(FloatDomainError)
      lambda { 1.0.divmod(0.0) }.should raise_error(FloatDomainError)
    end
  end

  ruby_version_is "1.9" do
    it "raises a ZeroDivisionError if other is zero" do
      lambda { 1.0.divmod(0)   }.should raise_error(ZeroDivisionError)
      lambda { 1.0.divmod(0.0) }.should raise_error(ZeroDivisionError)
    end
  end
end
