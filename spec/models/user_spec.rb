require 'spec_helper'

describe User do
  it "creates a user" do
    user = User.create(email: 'email@example.com',
     password: "abc123", password_confirmation: "abc123")
  end
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end
  it "is invalid without an email" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end
  it "is invalid with an email under 5 characters" do
    FactoryGirl.build(:user, email: '1234').should_not be_valid
  end
#  it "is invalid without correct email format " do
#    addresses = %w[user@foo,com user_at_foo.org example.user@foo.
#                 foo@bar_baz.com foo@bar+baz.com]
#    addresses.each do |invalid_address|
#      FactoryGirl.build(:user, 
#        email: invalid_address).should_not be_valid
#    end
#  end
  it "does not allow duplicate emails" do
    user = FactoryGirl.create(:user, email: 'wrong@example.com',
     password: "abc123", password_confirmation: "abc123")
    FactoryGirl.build(:user, email: 'wrong@example.com', password: "abc123",
     password_confirmation: "abc123").should_not be_valid
  end
  it "is invalid without a password" do
    FactoryGirl.build(:user, password: nil).should_not be_valid
  end
  it "is invalid without a password_confirmation" do
    FactoryGirl.build(:user, password_confirmation: nil).should_not be_valid
  end
  it "is invalid with a password under 5 characters" do
    FactoryGirl.build(:user, password: '1234').should_not be_valid
  end
  it "is not normally an admin" do
    user = FactoryGirl.create(:user)
    user.admin.should be_false
  end
  it "can be made an admin" do
    user = FactoryGirl.create(:user, admin: true)
    user.admin.should be_true
  end
end