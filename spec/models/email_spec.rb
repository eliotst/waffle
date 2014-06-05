  it "does not allow duplicate emails" do
    user = FactoryGirl(:user)
    FactoryGirl(email: 'wrong@example.com', password: "abc123",
     password_confirmation: "abc123")
    FactoryGirl.build(email: 'wrong@example.com', password: "abc123",
     password_confirmation: "abc123").should_not be_valid
  end