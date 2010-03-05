require 'spec_helper'

describe Account do

  
  # it "should require an email" do
  #     User.rb.make_unsaved(:email => nil).should_not be_valid
  #   end
  
  # it "should require a valid email" do
  #   User.rb.make_unsaved(:email => "test@test").should_not be_valid
  # end
  
  it "should have a unique login" do
    Account.make.should validate_uniqueness_of(:login)
  end
  
  it "should require a password" do
    Account.make_unsaved(:password => nil).should_not be_valid
  end
  
  it "should require a confirmation password" do
    Account.make_unsaved(:password_confirmation => nil).should_not be_valid
  end
  
  it "should require matching passwords" do
    Account.make_unsaved(:password_confirmation => "wrong").should_not be_valid
  end
  
  it "should require a password that is longer than 3 characters" do
    Account.make_unsaved(:password => "asd", :password_confirmation => "asd").should_not be_valid
  end
  
  it "should have many contacts" do
    Account.make.should have_many(:contacts)
  end
  
  it "should have many user preferences" do
    Account.make.should have_many(:user_preferences)
  end
  
  
  # State Tests
  it "should allow a state of registered" do
    a = Account.make
    a.state.should == "registered"
    a.current?.should == false
    a.invoiced?.should == false
    a.overdue?.should == false
    a.inactive?.should == false
  end
  
  it "should allow a state of active" do
    a = Account.make(:state => 'current')
    a.registered?.should == false
    a.current?.should == true
    a.invoiced?.should == false
    a.overdue?.should == false
    a.inactive?.should == false
  end
  
  it "should allow an invoiced state" do
    a = Account.make(:state => 'invoiced')
    a.registered?.should == false
    a.current?.should == false
    a.invoiced?.should == true
    a.overdue?.should == false
    a.inactive?.should == false
  end
  
  it "should allow an overdue state" do
    a = Account.make(:state => 'overdue')
    a.registered?.should == false
    a.current?.should == false
    a.invoiced?.should == false
    a.overdue?.should == true
    a.inactive?.should == false
  end
  
  
  # Disallowed state transitions
  it "should not allow transitions from registered to invoiced, paid, overdue or inactive" do
    a = Account.make
    a.invoice.should == false
    a.pay.should == false
    a.over.should == false
    a.deactivate.should == false
  end
  
  it "should not allow transitions from active to paid, overdue or activate" do
    a = Account.make(:state => 'current')
    a.activate.should == false
    a.pay.should == false
    a.over.should == false
  end
  
  it "should not allow transitions from invoiced to activate, invoiced" do
    a = Account.make(:state => 'invoiced')
    a.activate.should == false
    a.invoice.should == false
  end
  
  it "should not allow transitions from overdue to invoiced, overdue, or activate" do
    a = Account.make(:state => 'overdue')
    a.invoice.should == false
    a.over.should == false
    a.activate.should == false
  end
  
  
  # Allowed State Transitions
  it "should allow transitions from registered to current" do
    a = Account.make
    a.activate.should == true
    a.current?.should == true
  end
  
  it "should allow transitions from active to inactive" do
    a = Account.make(:state => 'current')
    a.deactivate.should == true
    a.inactive?.should == true
  end
  
  it "should allow transitions from active to current" do
    a = Account.make(:state => 'current')
    a.invoice.should == true
    a.invoiced?.should == true
  end
  
  it "should allow transitions from invoiced to overdue" do
    a = Account.make(:state => 'invoiced')
    a.over.should == true
    a.overdue?.should == true
  end
  
  it "should allow transitions from invoiced to inactive" do
    a = Account.make(:state => 'invoiced')
    a.deactivate.should == true
    a.inactive?.should == true
  end
  
  it "should allow transitions from invoiced to current" do
    a = Account.make(:state => 'invoiced')
    a.pay.should == true
    a.current?.should == true
  end
  
  it "should allow transitions from overdue to inactive" do
    a = Account.make(:state => 'overdue')
    a.deactivate.should == true
    a.inactive?.should == true
  end
  
  it "should allow transitions from overdue to current" do
    a = Account.make(:state => 'overdue')
    a.pay.should == true
    a.current?.should == true
  end
  
  # Plans
  it "should allow plans to be assigned to it" do
    a = Account.make()
    p = Plan.make()
    a.plans << p
    a.plans.count.should == 1
  end
  
  it "should allow more than one plan" do
    a = Account.make()
    p1 = Plan.make()
    p2 = Plan.make()
    a.plans << p1
    a.plans.count.should == 1
    a.plans << p2
    a.plans.count.should == 2
  end
  
  it "should require at least one plan"
  
end
