require 'spec_helper'

describe PlanItem do
  it "should require a plan" do
    PlanItem.make_unsaved(:plan => nil).should_not be_valid
  end

  it "should require a billable item" do
    PlanItem.make_unsaved(:billable_item => nil).should_not be_valid
  end
  
  it "should be deleted if the plan is deleted" do
    p = Plan.make
    p.billable_items << BillableItem.make
    lambda {
      p.destroy
    }.should change{PlanItem.count}
  end
  
  it "should be deleted if the billable item is deleted" do
    p = Plan.make
    b = BillableItem.make
    p.billable_items << b
    lambda {
      b.destroy
    }.should change{PlanItem.count}
  end
  
end
