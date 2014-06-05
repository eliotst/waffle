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
  it "is invalid without correct email format " do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                 foo@bar_baz.com foo@bar+baz.com]
    addresses.each do |invalid_address|
      FactoryGirl.build(:user, 
        email: invalid_address).should_not be_valid
    end
  end
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


=begin 
	before { @user = User.new(email: "tester@fandm.edu", password: "secret", 
		password_confirmation: "secret", address_line_one: "123 abc str.") }

	subject { @user }

	it { should respond_to (:email) }
	it { should respond_to (:password) }
	it { should respond_to (:password_confirmation) }
  it { should respond_to (:auth_token) }
  it { should respond_to (:authenticate) }
	it { should respond_to (:address_line_one) }
  it { should respond_to (:admin) }

rescue Exception => e
  
end
	it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end
	describe "when email is too long" do
	    before { @user.email = "a" * 51 }
	    it { should_not be_valid }
  	end
  	describe "when email is too short" do
	    before { @user.email = "a" * 3 }
	    it { should_not be_valid }
  	end
  	
	describe "when email format is valid" do
	    it "should be valid" do
	    	addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
	      	addresses.each do |valid_address|
	        	@user.email = valid_address
	        	expect(@user).to be_valid
	      	end
	    end
	end
	describe "when email address is already taken" do
    	before do
      		user_with_same_email = @user.dup
      		user_with_same_email.email = @user.email.upcase
      		user_with_same_email.save
    	end
		it { should_not be_valid }
  	end

  	describe "when password is not present" do
		before { @user.password = " ", @user.password_confirmation = " " }
		it { should_not be_valid }
	end
	describe "when password is too short" do
	    before { @user.password = "a" * 4 }
	    it { should_not be_valid }
  	end
  	describe "return value of authenticate method" do
		before { @user.save }
	 	let(:found_user) { User.find_by(email: @user.email) }

	  	describe "with valid password" do
	    	it { should eq found_user.authenticate(@user.password) }
	  	end

	  	describe "with invalid password" do
	    	let(:user_for_invalid_password) { found_user.authenticate("invalid") }

	    	it { should_not eq user_for_invalid_password }
	    	specify { expect(user_for_invalid_password).to be_false }
	  	end
	end

  describe "auth token" do
    before { @user.save }
    its(:auth_token) {should_not be_blank }
  end
=end
end
