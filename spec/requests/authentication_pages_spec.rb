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
end