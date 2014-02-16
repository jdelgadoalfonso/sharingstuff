class InvitationMailer < ActionMailer::Base
  default from: "no-reply@sharingstuff.net"
  
  def welcome_email(user)
    @user = user
    @url  = "http://www.sharingstuff.net"
    mail(:to => "ferrerchamorro.maria@gmail.com", :subject => "Welcome to My Awesome Site")
  end
end
