class UserMailer < ActionMailer::Base
  default from: "emotionlab@fandm.edu.com"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end
end
