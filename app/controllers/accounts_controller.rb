class AccountsController < ApplicationController
  before_filter :require_no_account, :only => [:new, :create]
  before_filter :require_account, :only => [:show, :edit, :update]
  
  def new
    @account = Account.new
    @account.contacts.build
  end
  
  
  def create
    @account = Account.new
    @account.contacts.build
    
    if @account.signup!(params)
      @account.deliver_activation_instructions!
      flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
      redirect_to root_url
    else
      render :action => :new
    end
  end
  
  
  def show
    @account = @current_account
  end
  
  
  def edit
    @account = @current_account
  end
  
  
  def update
    @account = @current_account # makes our views "cleaner" and more consistent
    if @account.update_attributes(params[:account])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end
