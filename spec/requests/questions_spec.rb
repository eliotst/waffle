require 'spec_helper'

describe "Questions" do
  describe "with valid information" do
    let(:user) { FactoryGirl.create(:user, admin: true) }
    let(:question) { FactoryGirl.create(:question) }

    before(:each) do
      log_in user
    end
    before { visit questions_path }

    describe "GET /questions" do
      it "GETs the questions page" do
        # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
        get questions_path
        response.status.should be(200)
      end
    end
  end
end
