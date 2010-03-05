class Notifier < ActionMailer::Base
  
  def activation_instructions(account)
    subject       "Activation Instructions"
    from          "Binary Logic Notifier <noreply@binarylogic.com>"
    recipients    account.contacts[0].email
    sent_on       Time.now
    body          :account_activation_url => register_url(account.perishable_token)
  end

  def activation_confirmation(account)
    subject       "Activation Complete"
    from          "Binary Logic Notifier <noreply@binarylogic.com>"
    recipients    account.contacts[0].email
    sent_on       Time.now
    body          :root_url => root_url
  end

end
