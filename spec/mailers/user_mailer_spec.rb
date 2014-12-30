require "spec_helper"

describe UserMailer do
  user = User.create(email: 'email@example.com', 
    password: "abc123", password_confirmation: "abc123", auth_token: "fake",
    valid_token: "fake")
  describe "password_reset" do
    let(:mail) { UserMailer.password_reset(user) }

    it "renders the headers" do
      mail.subject.should eq("Password Reset")
      mail.to.should eq([user.email])
      mail.from.should eq(["emotionlab@fandm.edu"])
    end

    it "renders the body" do
      mail.body.encoded.should match(
        "To reset your password, click the URL below. The URL will be live for " + 
        "3 hours.\r\n\r\n#{edit_password_reset_url(user.auth_token)}\r\n\r\n" + 
        "If you did not request your password to be reset, just ignore this " + 
        "email and your password will continue to stay the same.")
    end
  end

  describe "validation" do
    let(:mail) { UserMailer.validation(user) }

    it "renders the headers" do
      mail.subject.should eq("Validation Email")
      mail.to.should eq([user.email])
      mail.from.should eq(["emotionlab@fandm.edu"])
    end

    it "renders the body" do
      mail.body.encoded.should match(
        "To validate your account, click the URL below.\r\n\r\n" +
        "#{edit_validation_url(user.valid_token)}\r\n")
    end
  end
end
