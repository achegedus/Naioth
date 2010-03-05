require 'spec_helper'

describe ContactType do

  it "should create a new instance given valid attributes" do
    ContactType.make
  end
  
  it "should require a name" do
    ContactType.make_unsaved(:name => nil).should_not be_valid
  end
end
