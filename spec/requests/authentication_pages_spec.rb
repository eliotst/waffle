require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "log_in page" do
    before { visit log_in_path }
    
    it { should have_content('Log in') }
    it { should have_title('Log in') }
  end

  describe "log_in" do
    before { visit log_in_path }

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { log_in user }

      it { should have_title('User Home Page') }
      it { should have_link('Edit Account',href: edit_user_path(user)) }
      it { should have_link('Settings',    href: edit_user_path(user)) }
      it { should have_link('Log out',     href: log_out_path) }
      it { should_not have_link('Log in',  href: log_in_path) }

      describe "followed by log out" do
        before { click_link "Log out" }
        it { should have_link('Log in') }
      end
    end

    describe "with invalid information" do
      before { click_button "Log in" }

      it { should have_title('Log in') }
      it { should have_selector('div.alert.alert-error') }

      describe "after visiting another page" do 
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
  end
  describe "authorization" do

    describe "for non-logged-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Log in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_title('Edit user')
          end
        end
      end

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Log in') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(log_in_path) }
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('Log in') }
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { log_in user, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { log_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
  end
end