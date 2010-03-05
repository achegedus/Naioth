require 'spec_helper'

describe Plan do

  it "should require a description" do
    Plan.make_unsaved(:description => nil).should_not be_valid
  end
  
  it "should require a cost" do
    Plan.make_unsaved(:cost => nil).should_not be_valid
  end
  
  it "should allow many billable items through plan items" do
    p = Plan.make
    
    lambda {
      p.billable_items << BillableItem.make
    }.should change{p.plan_items.count}
  end
  
end
