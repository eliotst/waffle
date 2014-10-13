require 'spec_helper'

describe QuestionnairesController, type: :controller do
  before(:each) do
    @admin_user = create(:user, admin: true)
    @regular_user = create(:user)
  end
  describe "showing" do
    before(:each) do
      @questionnaire = create(:questionnaire)
    end
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "showable controller" do
        let(:model) { @questionnaire }
        let(:model_variable) { :questionnaire }
      end
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
      end
      it_behaves_like "unauthorized access handler" do
        let!(:action) do
          get 'show', id: @questionnaire.id
        end
      end
    end
    context "as no one" do
      it_behaves_like "not logged in handler" do
        let!(:action) { get :show, id: @questionnaire.id }
      end
    end
  end

  describe "creating" do
    let(:valid_model_parameters) {
      {
        label: "questionnaire_one"
      }
    }
    let(:invalid_model_parameters) {
      {
        label: "questionnaire number one"
      }
    }
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "createable controller" do
        let(:model_variable) { :questionnaire }
        let(:model_class) { Questionnaire }
      end
      describe "nested parameters" do
      end
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
      end
      describe "new" do
        it_behaves_like "unauthorized access handler" do
          let!(:action) do
            get 'new'
          end
        end
      end
      describe "create" do
        it_behaves_like "unauthorized access handler" do
          let!(:action) do
            get 'new'
          end
        end
        it "doesn't create a new questionnaire" do
          expect {
            post 'create', valid_model_parameters
          }.to change(Questionnaire, :count).by(0)
        end
      end
    end
    context "as no one" do
      describe "new" do
        it_behaves_like "not logged in handler" do
          let!(:action) do
            get 'new'
          end
        end
      end
      describe "create" do
        it_behaves_like "not logged in handler" do
          let!(:action) do
            post :create, valid_model_parameters
          end
        end
        it "doesn't create a new questionnaire" do
          expect {
            post 'create', valid_model_parameters
          }.to change(Questionnaire, :count).by(0)
        end
      end
    end
  end

  describe "editing" do
    before(:each) do
      @questionnaire = create(:questionnaire)
    end
    let(:model_variable) { :questionnaire }
    let(:model_class) { Questionnaire }
    let(:model) { @questionnaire }
    let(:valid_model_parameters) {
      {
        label: "questionnaire_one"
      }
    }
    let(:invalid_model_parameters) {
      {
        label: "questionnaire number one"
      }
    }
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "editable controller"
      describe "nested parameters" do
      end
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
      end
      describe "edit" do
        it_behaves_like "unauthorized access handler" do
          let!(:action) do
            get 'edit', id: @questionnaire.id
          end
        end
      end
      describe "update" do
        it_behaves_like "unauthorized access handler" do
          let!(:action) do
            get 'edit', id: @questionnaire.id
          end
        end
        it "doesn't update the study" do
          expect {
            post 'update', id: @questionnaire.id,
              study: valid_model_parameters
          }.not_to change { @questionnaire }
        end
      end
    end
    context "as no one" do
      describe "edit" do
        it_behaves_like "not logged in handler" do
          let!(:action) do
            get 'edit', id: @questionnaire.id
          end
        end
      end
      describe "update" do
        it_behaves_like "not logged in handler" do
          let!(:action) do
            post 'update', id: @questionnaire.id, questionnaire: valid_model_parameters
          end
        end
        it "doesn't update the study" do
          expect {
            post 'update', id: @questionnaire.id, questionnaire: valid_model_parameters
          }.not_to change { @questionnaire }
        end
      end
    end
  end

  describe "indexing" do
    before(:each) do
      @questionnaire_one = create(:questionnaire)
      @questionnaire_two = create(:questionnaire)
      @questionnaires = [ @questionnaire_one, @questionnaire_two ]
    end
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "indexable controller" do
        let(:model_list) { @questionnaires }
        let(:list_variable) { :questionnaires }
      end
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
      end
      it_behaves_like "unauthorized access handler" do
        let!(:action) do
          get 'index'
        end
      end
    end
    context "as no one" do
      it_behaves_like "not logged in handler" do
        let!(:action) { get :index }
      end
    end
  end

  describe "destroying" do
    before(:each) do
      @questionnaire = create(:questionnaire)
    end
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "destroyable controller" do
        let(:model) { @questionnaire }
        let(:model_class) { Questionnaire }
        let(:resulting_page) { questionnaires_path }
      end
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
      end
      it_behaves_like "unauthorized access handler" do
        let!(:action) do
          delete 'destroy', :id => @questionnaire.id
        end
      end
      it "does not delete anything" do
        expect {
          delete 'destroy', :id => @questionnaire.id
        }.not_to change { Questionnaire.count }
      end
    end
    context "as no one" do
      it_behaves_like "not logged in handler" do
        let!(:action) do
          delete 'destroy', :id => @questionnaire.id
        end
      end
      it "does not delete anything" do
        expect {
          delete 'destroy', :id => @questionnaire.id
        }.not_to change { Questionnaire.count }
      end
    end
  end
end
