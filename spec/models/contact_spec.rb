require 'spec_helper'

describe Contact do
  it "should create an contact" do
    Contact.make(:country => "US")
  end
  
  it "should require a first name" do
    Contact.make_unsaved(:first_name => nil, :country => "US").should_not be_valid
  end

  it "should require a last name" do
    Contact.make_unsaved(:last_name => nil, :country => "US").should_not be_valid
  end
  
  it "should require a street address" do
    Contact.make_unsaved(:address1 => nil, :country => "US").should_not be_valid
  end
  
  it "should require a company" do
    Contact.make_unsaved(:company => nil, :country => "US").should_not be_valid
  end
  
  it "should require a city" do
    Contact.make_unsaved(:city => nil, :country => "US").should_not be_valid
  end
  
  it "should require a state" do
    Contact.make_unsaved(:state => nil, :country => "US").should_not be_valid
  end
  
  it "should require a zipcode" do
    Contact.make_unsaved(:zip => nil, :country => "US").should_not be_valid
  end
  
  it "should require an email" do
    Contact.make_unsaved(:email => nil).should_not be_valid
  end
  
  it "should require a valid email" do
    Contact.make_unsaved(:email => "test@test").should_not be_valid
  end
  
  it "should require a country" do
    Contact.make_unsaved(:country => nil).should_not be_valid
  end
  
  it "should be dependent on an account" do
    a = Contact.make(:country => "US")
    u = a.account
    lambda {
      u.destroy
    }.should change{Account.count}
  end
  
end