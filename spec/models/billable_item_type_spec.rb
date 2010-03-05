require 'spec_helper'

describe BillableItemType do
  it "should require a name" do
    BillableItemType.make_unsaved(:name => nil).should_not be_valid
  end
  
end
