require 'spec_helper'

describe UsersController, type: :controller do
  describe "showing" do
    describe "yourself" do
      context "as an admin" do
        before(:each) do
          @admin_user = create(:user, admin: true)
          log_in(@admin_user)
        end
        it_behaves_like "showable controller" do
          let(:model) { @admin_user }
          let(:model_variable) { :user }
        end
      end
      context "as a regular user" do
        before(:each) do
          @regular_user = create(:user)
          log_in(@regular_user)
        end
        it_behaves_like "showable controller" do
          let(:model) { @regular_user }
          let(:model_variable) { :user }
        end
      end
      context "as no one" do
        it_behaves_like "not logged in handler" do
          let!(:action) { get :index }
        end
      end
    end
    describe "another user" do
      context "as an admin" do
        before(:each) do
          @admin_user = create(:user, admin: true)
          @other_user = create(:user)
          log_in(@admin_user)
        end
        it_behaves_like "showable controller" do
          let(:model) { @other_user }
          let(:model_variable) { :user }
        end
      end
      context "as a regular user" do
        before(:each) do
          @regular_user = create(:user)
          @other_user = create(:user)
          log_in(@regular_user)
        end
        it_behaves_like "unauthorized access handler" do
          let!(:action) do
            get 'show', id: @other_user.id
          end
        end
      end
      context "as no one" do
        it_behaves_like "not logged in handler" do
          let!(:action) { get :index }
        end
      end
    end
  end

  describe "creating" do
    let(:valid_model_parameters) {
      {
        email: "user@test.com",
        password: "password1234",
        password_confirmation: "password1234"
      }
    }
    let(:invalid_model_parameters) {
      {
        email: "user@test.com",
        password: "password1234",
        password_confirmation: "password"
      }
    }
    context "as an admin" do
      before(:each) do
        @admin_user = create(:user, admin: true)
        log_in(@admin_user)
      end
      it_behaves_like "createable controller" do
        let(:model_variable) { :user }
        let(:model_class) { User }
      end
    end
    context "as a regular user" do
      before(:each) do
        @regular_user = create(:user)
        log_in(@regular_user)
      end
      describe "new" do
        it "redirects to the root url" do
          post :create, valid_model_parameters
          response.should redirect_to root_url
        end
      end
      describe "create" do
        it "redirects to the root url" do
          post :create, valid_model_parameters
          response.should redirect_to root_url
        end
        it "doesn't create a new user" do
          expect {
            post 'create', valid_model_parameters
          }.to change(User, :count).by(0)
        end
      end
    end
    context "as no one" do
      it_behaves_like "createable controller" do
        let(:model_variable) { :user }
        let(:model_class) { User }
      end
    end
  end

  describe "editing" do
    let(:valid_model_parameters) {
      {
        email: "user@test.com"
      }
    }
    let(:invalid_model_parameters) {
      {
        email: "user"
      }
    }
    describe "yourself" do
      context "as an admin" do
        before(:each) do
          @admin_user = create(:user, admin: true)
          log_in(@admin_user)
        end
        it_behaves_like "editable controller" do
          let(:model) { @admin_user }
          let(:model_variable) { :user }
        end
      end
      context "as a regular user" do
        before(:each) do
          @regular_user = create(:user)
          log_in(@regular_user)
        end
        it_behaves_like "editable controller" do
          let(:model) { @regular_user }
          let(:model_variable) { :user }
        end
      end
    end
    describe "another user" do
      context "as an admin" do
        before(:each) do
          @admin_user = create(:user, admin: true)
          @other_user = create(:user)
          log_in(@admin_user)
        end
        it_behaves_like "editable controller" do
          let(:model) { @other_user }
          let(:model_variable) { :user }
        end
      end
      context "as a regular user" do
        before(:each) do
          @regular_user = create(:user)
          @other_user = create(:user)
          log_in(@regular_user)
        end
        describe "edit" do
          it_behaves_like "unauthorized access handler" do
            let!(:action) do
              get 'edit', id: @other_user.id
            end
          end
        end
        describe "update" do
          it_behaves_like "unauthorized access handler" do
            let!(:action) do
              get 'update', id: @other_user.id, :user => valid_model_parameters
            end
          end
        end
      end
    end
    context "as no one" do
      before(:each) do
        @other_user = create(:user)
      end
      describe "edit" do
        it_behaves_like "not logged in handler" do
          let!(:action) do
            get 'edit', id: @other_user.id
          end
        end
      end
      describe "update" do
        it_behaves_like "not logged in handler" do
          let!(:action) do
            get 'update', id: @other_user.id, :user => valid_model_parameters
          end
        end
      end
    end
  end

  describe "indexing" do
    context "as an admin" do
      before(:each) do
        @admin_user = create(:user, admin: true)
        @users_list = [ @admin_user, create(:user), create(:user) ]
        log_in(@admin_user)
      end
      it_behaves_like "indexable controller" do
        let(:model_list) { @users_list }
        let(:list_variable) { :users }
      end
    end
    context "as a regular user" do
      before(:each) do
        @regular_user = create(:user)
        @users_list = [ @regular_user, create(:user), create(:user) ]
        log_in(@regular_user)
      end
      it_behaves_like "indexable controller" do
        let(:model_list) { @users_list }
        let(:list_variable) { :users }
      end
    end
    context "as no one" do
      it_behaves_like "not logged in handler" do
        let!(:action) { get :index }
      end
    end
  end

  describe "destroying" do
    describe "yourself" do
      context "as an admin" do
        before(:each) do
          @admin_user = create(:user, admin: true)
          log_in(@admin_user)
        end
        it_behaves_like "destroyable controller" do
          let(:model) { @admin_user }
          let(:model_class) { User }
          let(:resulting_page) { root_url }
        end
      end
      context "as a regular user" do
        before(:each) do
          @regular_user = create(:user)
          log_in(@regular_user)
        end
        it_behaves_like "destroyable controller" do
          let(:model) { @regular_user }
          let(:model_class) { User }
          let(:resulting_page) { root_url }
        end
      end
      context "as no one" do
        it_behaves_like "not logged in handler" do
          let!(:action) { get :index }
        end
      end
    end
    describe "another user" do
      context "as an admin" do
        before(:each) do
          @admin_user = create(:user, admin: true)
          @other_user = create(:user)
          log_in(@admin_user)
        end
        it_behaves_like "destroyable controller" do
          let(:model) { @other_user }
          let(:model_class) { User }
          let(:resulting_page) { users_url }
        end
      end
      context "as a regular user" do
        before(:each) do
          @regular_user = create(:user)
          @other_user = create(:user)
          log_in(@regular_user)
        end
        it_behaves_like "unauthorized access handler" do
          let!(:action) do
            get 'show', id: @other_user.id
          end
        end
      end
      context "as no one" do
        it_behaves_like "not logged in handler" do
          let!(:action) { get :index }
        end
      end
    end
  end
end
