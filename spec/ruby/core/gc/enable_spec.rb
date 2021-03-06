require File.dirname(__FILE__) + '/../../spec_helper'

describe "GC.enable" do

  it "returns true iff the garbage collection was already disabled" do
    GC.enable.should == false
    GC.disable
    GC.enable.should == true
    GC.enable.should == false
  end

end
