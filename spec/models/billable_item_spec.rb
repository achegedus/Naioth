require 'spec_helper'

describe BillableItem do
  it "should require a billable item type" do
    BillableItem.make_unsaved(:billable_item_type => nil).should_not be_valid
  end
  
  it "should require a name" do
    BillableItem.make_unsaved(:name => nil).should_not be_valid
  end
end
