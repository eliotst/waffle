require 'spec_helper'

describe UsersController, type: :controller do
  describe "indexing" do
    before(:each) do
      @users_list = [ create(:user), create(:user) ]
    end
    it_behaves_like "indexable controller" do
      let(:model_list) { @users_list }
      let(:list_variable) { :users }
    end
  end
end
