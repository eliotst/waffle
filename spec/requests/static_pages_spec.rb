require 'spec_helper'

describe "StaticPages" do
  describe "GET /static_pages" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get static_pages_home_path
      response.status.should be(200)
    end
  end
  describe "Home page" do
    it "should have the title 'Waffle Home'" do
      visit '/static_pages/home'
      expect(page).to have_title('Waffle Home')
    end
    it "should have a waffle" do
      visit '/static_pages/home'
      expect(page).to have_xpath("//img[@src = '/assets/waffle.png']")
    end
  end
  describe "About page" do
    it "should have the title 'About Us'"
      visit 'static_pages/about'
      expect(page).to have_title('About Us')
    end
  end
end
