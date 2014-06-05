require 'spec_helper'

describe User do
  it "has a valid factory"
  it "is invalid without an email"
  it "is invalid without a password"
  it "is invalid without a password_confirmation"
  it "has a unique email"
  it "has a password over 5 characters"


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
  	describe "when email format is invalid" do
	    it "should be invalid" do
	      	addresses = %w[user@foo,com user_at_foo.org example.user@foo.
	                     foo@bar_baz.com foo@bar+baz.com]
	      	addresses.each do |invalid_address|
	        	@user.email = invalid_address
	        	expect(@user).not_to be_valid
	      	end
	    end
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
