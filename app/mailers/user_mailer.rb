class UserMailer < ActionMailer::Base
  default from: "emotionlab@fandm.edu"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end

  def validation(user)
    @user = user
    mail :to => user.email, :subject => "Validation Email"
  end
end
