require 'spec_helper'

describe "UserPages" do

	subject { page }

	describe "sign_up page" do
		before { visit sign_up_path }

		it { should have_content('Sign Up') }
		it { should have_title('Sign Up') }
  	end

  	describe "sign_up" do

	    before { visit sign_up_path }

	    let(:submit) { "Create my account" }

	    describe "with invalid information" do
	      it "should not create a user" do
	        expect { click_button submit }.not_to change(User, :count)
	      end
	    end

	    describe "with valid information" do
	      before do
	        fill_in "email",     						 with: "user@example.com"
	        fill_in "password",    					 with: "foobar"
	        fill_in "password_confirmation", with: "foobar"
	      end

	      it "should create a user" do
	        expect { click_button submit }.to change(User, :count).by(1)
	      end
	    end
	end
end