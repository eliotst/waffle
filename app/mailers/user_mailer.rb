class UserMailer < ActionMailer::Base
  default from: "test@waffle.eliothstone.com"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end

  def validation(user)
    @user = user
    mail :to => user.email, :subject => "Validation Email"
  end

  def notify(schedule_entry)
    @schedule_entry = schedule_entry
    mail :to => user.email, :subject => "New Questionnaire!"
    @schedule_entry.sent = true
    @schedule_entry.save
  end
end
