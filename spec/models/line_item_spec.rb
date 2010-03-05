require 'spec_helper'

describe LineItem do
  
  before(:each) do
    SystemPreferences.make(:key=>"invoice_number", :value=>"1000")
  end
  
  it "should create a new instance given valid attributes" do
    LineItem.make
  end
  
  it "should belong to an invoice" do
    inv = Invoice.make
    li = LineItem.make(:invoice => inv)
    lambda {
      inv.destroy
    }.should change{LineItem.count}
  end
  
  it "should require a description" do
    LineItem.make_unsaved(:description => nil).should_not be_valid
  end
  
  it "should require a cost" do
    LineItem.make_unsaved(:cost => nil).should_not be_valid
  end
  
  it "should update invoice cost on save" do
    inv = Invoice.make(:cost => 0)
    assert inv.cost == 0
    a = LineItem.make_unsaved(:invoice => inv, :cost => 2000)
    a.save
    assert inv.cost == a.cost
  end
  
end
