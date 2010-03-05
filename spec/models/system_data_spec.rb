require 'spec_helper'

describe SystemPreferences do
  it "should create a new instance given valid attributes" do
    SystemPreferences.make(:key => "test", :value => 25)
  end
  
  it "should require a key" do
    SystemPreferences.make_unsaved(:key => nil).should_not be_valid
  end
  
  it "should require a value" do
    SystemPreferences.make_unsaved(:value => nil).should_not be_valid
  end
  
  it "should not allow repeat keys" do
    SystemPreferences.make
    SystemPreferences.make_unsaved.should_not be_valid
  end
  
end
