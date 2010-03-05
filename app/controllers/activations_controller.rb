class ActivationsController < ApplicationController
  before_filter :require_no_account, :only => [:new]

  def new
    @account = Account.find_using_perishable_token(params[:activation_code], 1.week)
    if @account
      if @account.active?
        flash[:notice] = "This account has already been activated."
        redirect_to new_account_session_url
      else
        if @account.activate!
          @account.deliver_activation_confirmation!
          flash[:notice] = "Your account has been activated."
          redirect_to new_account_session_url
        else
          redirect_to new_account_url
        end
      end
    else
      flash[:notice] = "An error occurred."
      redirect_to new_account_session_url
    end
  end
end
