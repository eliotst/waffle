class UserMailer < ActionMailer::Base
  default from: "test@waffle.emo-lab.org"

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
    @user = @schedule_entry.participant.user
    mail :to => @user.email, :subject => "New Questionnaire"
  end
end
