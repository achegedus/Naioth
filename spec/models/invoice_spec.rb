require 'spec_helper'

describe Invoice do
  before(:each) do
    SystemPreferences.make(:key=>"invoice_number", :value=>"1000")
  end
  
  it "should create a new instance given valid attributes" do
    Invoice.make
  end
  
  it "should belong to an account" do
    acct = Account.make
    Invoice.make(:account => acct)
    acct.invoices.count.should == 1
  end
  
  it "should require an invoice date" do
    Invoice.make_unsaved(:date => nil).should_not be_valid
  end
  
  it "should require a state" do
    Invoice.make_unsaved(:state => nil).should_not be_valid
  end
  
  it "should not require a URL" do
    Invoice.make_unsaved(:url => nil).should be_valid
  end
  
  it "should not require an external id" do
    Invoice.make_unsaved(:external => nil).should be_valid
  end
  
  it "should require a total cost" do
    Invoice.make_unsaved(:cost => nil).should_not be_valid
  end
  
  it "should automatically generate an invoice id" do
    a = Invoice.make_unsaved(:invoice_number => nil)
    a.invoice_number.should == nil
    a.save
    a.invoice_number.should_not == nil
  end
  
  it "should increment the invoice id" do
    a = Invoice.make
    b = Invoice.make
    assert a.invoice_number < b.invoice_number
  end
  
  
  # State Test
  it "should allow a state of created" do
    a = Invoice.make
    a.state.should == "created"
    a.created?.should == true
    a.sent?.should == false
    a.received?.should == false
    a.paid?.should == false
  end
  
  it "should allow a state of sent" do
    a = Invoice.make(:state => "sent")
    a.state.should == "sent"
    a.created?.should == false
    a.sent?.should == true
    a.received?.should == false
    a.paid?.should == false
  end
  
  it "should allow a state of received" do
    a = Invoice.make(:state => "received")
    a.state.should == "received"
    a.created?.should == false
    a.sent?.should == false
    a.received?.should == true
    a.paid?.should == false
  end
  
  it "should allow a state of paid" do
    a = Invoice.make(:state => "paid")
    a.state.should == "paid"
    a.created?.should == false
    a.sent?.should == false
    a.received?.should == false
    a.paid?.should == true
  end
  
  # Allowed State Transitions
  it "should allow transitions from created to sent" do
    a = Invoice.make
    a.email.should == true
    a.sent?.should == true
  end
  
  it "should allow transitions from sent to received" do
    a = Invoice.make(:state => "sent")
    a.receive.should == true
    a.received?.should == true
  end
  
  it "should allow transitions from received to paid" do
    a = Invoice.make(:state => "received")
    a.pay.should == true
    a.paid?.should == true
  end
  
  # Disallowed State Transitions
  it "should not allow transitions from created to received, paid" do
    a = Invoice.make
    a.received?.should == false
    a.paid?.should == false
  end
  
  it "should not allow transitions from sent to paid, created" do
    a = Invoice.make(:state => "sent")
    a.created?.should == false
    a.paid?.should == false
  end
  
  it "should not allow transitions from received to created, sent" do
    a = Invoice.make(:state => "received")
    a.created?.should == false
    a.sent?.should == false
  end
  
  it "should not allow transitions from paid to received, created, sent" do
    a = Invoice.make(:state => "paid")
    a.received?.should == false
    a.created?.should == false
    a.sent?.should == false
  end
  
  # Line items
  it "should allow many line items" do
    i = Invoice.make
    l1 = LineItem.make_unsaved(:invoice => nil)
    l2 = LineItem.make_unsaved(:invoice => nil)
    l3 = LineItem.make_unsaved(:invoice => nil)
    i.line_items << l1
    i.line_items << l2
    i.line_items << l3
    i.line_items.count.should == 3
  end
  
end
