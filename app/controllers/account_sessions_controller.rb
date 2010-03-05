class AccountSessionsController < ApplicationController
  before_filter :require_no_account, :only => [:new, :create]
  before_filter :require_account, :only => :destroy

  def new
    @account_session = AccountSession.new
  end

  def create
    @account_session = AccountSession.new(params[:account_session])
    if @account_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end

  def destroy
    current_account_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_account_session_url
  end
end
