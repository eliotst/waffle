require 'spec_helper'

describe User do
  it "creates a user" do
    user = User.create(email: 'email@example.com',
      password: "abc123", password_confirmation: "abc123")
  end
  it "has a valid factory" do
    create(:user).should be_valid
  end
  it "is invalid without an email" do
    build(:user, email: nil).should_not be_valid
  end
  it "is invalid with an email under 5 characters" do
    build(:user, email: '1234').should_not be_valid
  end
  it "does not allow duplicate emails" do
    user = create(:user, email: 'wrong@example.com',
      password: "abc123", password_confirmation: "abc123")
    build(:user, email: 'wrong@example.com', password: "abc123",
      password_confirmation: "abc123").should_not be_valid
  end
  it "is invalid without a password" do
    build(:user, password: nil).should_not be_valid
  end
  it "is invalid without a password_confirmation" do
    build(:user, password_confirmation: nil).should_not be_valid
  end
  it "is invalid with a password under 5 characters" do
    build(:user, password: '1234').should_not be_valid
  end
  it "is not normally an admin" do
    user = create(:user)
    user.admin.should be_false
  end
  it "can be made an admin" do
    user = create(:user, admin: true)
    user.admin.should be_true
  end
  it "has an email that can be valid" do
    user = create(:user, is_valid: true)
    user.is_valid.should be_true
  end
end
