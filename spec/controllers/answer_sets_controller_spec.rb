require 'spec_helper'

describe AnswerSetsController, type: :controller do
  before(:each) do
    @admin_user = create(:admin)
    @regular_user = create(:user)
  end

  describe "showing" do
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
        @answer_set = create(:answer_set)
      end
      it_behaves_like "showable controller" do
        let(:model) { @answer_set }
        let(:model_variable) { :answer_set }
      end
    end
    context "as a regular user" do
      describe "for their own participant" do
        before(:each) do
          @participant = create(:participant, user: @regular_user)
          @answer_set = create(:answer_set, participant: @participant)
          log_in(@regular_user)
        end
        it_behaves_like "showable controller" do
          let(:model) { @answer_set }
          let(:model_variable) { :answer_set }
        end
      end
      describe "for another participant" do
        before(:each) do
          @answer_set = create(:answer_set)
          log_in(@regular_user)
        end
        it_behaves_like "unauthorized access handler" do
          let!(:action) { get :show, id: @answer_set.id }
        end
      end
    end
    context "as no one" do
      before(:each) do
        @answer_set = create(:answer_set)
      end
      it_behaves_like "not logged in handler" do
        let!(:action) { get :show, id: @answer_set.id }
      end
    end
  end

  describe "creating" do
    before(:each) do
      @questionnaire = create(:questionnaire_with_blocks)
      @question = create(:question, block: @questionnaire.blocks.first)
    end
    let(:valid_model_parameters) {
      {
        questionnaire_id: @questionnaire.id,
        answers_attributes: [
          {
            question_id: @question.id,
            value: 2
          }
        ]
      }
    }
    let(:invalid_model_parameters) {
      {
        questionnaire_id: @questionnaire.id,
        answers_attributes: [
          {
            question_id: @question.id,
            value: "foo"
          }
        ]
      }
    }
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
        @participant = create(:participant, user: @admin_user, study: @questionnaire.study)
      end
      it_behaves_like "createable controller" do
        let(:model_variable) { :answer_set }
        let(:model_class) { AnswerSet }
        let(:new_params) { { questionnaire_id: @questionnaire.id } }
      end
      it_behaves_like "createable with nested attributes controller" do
        let(:model_variable) { :answer_set }
        let(:child_class) { Answer }
        let(:number_of_children) { 1 }
      end
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
        @participant = create(:participant, user: @regular_user, study: @questionnaire.study)
      end
      describe "create" do
        it_behaves_like "createable controller" do
          let(:model_variable) { :answer_set }
          let(:model_class) { AnswerSet }
          let(:new_params) { { questionnaire_id: @questionnaire.id } }
        end
        it_behaves_like "createable with nested attributes controller" do
          let(:model_variable) { :answer_set }
          let(:child_class) { Answer }
          let(:number_of_children) { 1 }
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
        it "doesn't create a new answer_set" do
          expect {
            post 'create', valid_model_parameters
          }.to change(AnswerSet, :count).by(0)
        end
      end
    end
  end

  describe "indexing" do
    before(:each) do
      @answer_set_one = create(:answer_set)
      @answer_set_two = create(:answer_set)
      @answer_sets = [ @answer_set_one, @answer_set_two ]
    end
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "indexable controller" do
        let(:model_list) { @answer_sets }
        let(:list_variable) { :answer_sets }
      end
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
      end
      it_behaves_like "unauthorized access handler" do
        let!(:action) { get :index }
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
      @answer_set = create(:answer_set)
    end
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "destroyable controller" do
        let(:model) { @answer_set }
        let(:model_class) { AnswerSet }
        let(:resulting_page) { answer_sets_path }
      end
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
      end
      it_behaves_like "unauthorized access handler" do
        let!(:action) do
          delete 'destroy', :id => @answer_set.id
        end
      end
      it "does not delete anything" do
        expect {
          delete 'destroy', :id => @answer_set.id
        }.not_to change { AnswerSet.count }
      end
    end
    context "as no one" do
      it_behaves_like "not logged in handler" do
        let!(:action) do
          delete 'destroy', :id => @answer_set.id
        end
      end
      it "does not delete anything" do
        expect {
          delete 'destroy', :id => @answer_set.id
        }.not_to change { AnswerSet.count }
      end
    end
  end
end
