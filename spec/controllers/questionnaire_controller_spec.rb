require 'spec_helper'

describe QuestionnairesController, type: :controller do
  before(:each) do
    @admin_user = create(:admin)
    @regular_user = create(:user)
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
      it_behaves_like "createable ajax controller" do
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
      describe "create" do
        it_behaves_like "unauthorized access handler" do
          let!(:action) do
            post 'create', valid_model_parameters
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
      it_behaves_like "editable ajax controller"
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
      end
      describe "update" do
        it_behaves_like "unauthorized access handler" do
          let!(:action) do
            post 'update', id: @questionnaire.id,
              questionnaire: valid_model_parameters
          end
        end
        it "doesn't update the questionnaire" do
          expect {
            post 'update', id: @questionnaire.id,
              questionnaire: valid_model_parameters
          }.not_to change { @questionnaire }
        end
      end
    end
    context "as no one" do
      describe "update" do
        it_behaves_like "not logged in handler" do
          let!(:action) do
            post 'update', id: @questionnaire.id, questionnaire: valid_model_parameters
          end
        end
        it "doesn't update the questionnaire" do
          expect {
            post 'update', id: @questionnaire.id, questionnaire: valid_model_parameters
          }.not_to change { @questionnaire }
        end
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
      it_behaves_like "destroyable ajax controller" do
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
