require 'spec_helper'

describe AccountsController do

  describe :new do
    it "should be a success" do
      get :new
      response.should be_success
    end

    it "should render the new.html.haml" do
      get :new
      response.should render_template(:new)
    end
  end


  describe :create do
    before(:each) do
      
    end
    
    it "should be a success" do
      
    end

    it "saves a new account"
    it "notifies the user of the successful signup"
    it "sends an email upon signup"
    it "redirects the user if signup was successful"
    it "redirects user to the form if signup failed"
    it "should render create.html.haml"
  end


  describe :show do
    it "returns the current account object"
  end


  describe :edit do
    it "returns the current account object"
  end


  describe :update do
    it "saves the account object"
    it "notifies the user of a successful save"
    it "redirects the user to the form if save failed"
    it "redirects the user if the save is successful"
  end
end