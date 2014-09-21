shared_examples "authenticating indexable controller" do
  describe "with an authorized user" do
    before(:each) do
      log_in(:authorized_user)
    end
    it_behaves_like "indexable controller"
  end
  describe "with an unauthorized user" do
    before(:each) do
      log_in(:unauthorized_user)
    end
    it_behaves_like "failed authorization handler"
  end
end

shared_examples "authenticating showable controller" do
  describe "with an authorized user" do
    before(:each) do
      log_in(:authorized_user)
    end
    it_behaves_like "showable controller"
  end
  describe "with an unauthorized user" do
    before(:each) do
      log_in(:unauthorized_user)
    end
    it_behaves_like "failed authorization handler"
  end
end
