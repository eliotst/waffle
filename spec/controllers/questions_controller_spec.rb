require 'spec_helper'

describe QuestionsController, type: :controller do
  before(:each) do
    @admin_user = create(:admin)
    @regular_user = create(:user)
  end

  describe "creating" do
    before(:each) do
      @answer_type = create(:answer_type, label: "answer_type")
    end
    let(:valid_model_parameters) {
      {
        label: "question_one",
        text: "Question?",
        answer_type_id: @answer_type.id
      }
    }
    let(:invalid_model_parameters) {
      {
        label: "question number one",
        text: "Question?",
        answer_type_id: @answer_type.id
      }
    }
    context "as an admin" do
      let(:model_variable) { :question }
      let(:model_class) { Question }
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "createable ajax controller"
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
        it "doesn't create a new question" do
          expect {
            post 'create', valid_model_parameters
          }.to change(Question, :count).by(0)
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
        it "doesn't create a new question" do
          expect {
            post 'create', valid_model_parameters
          }.to change(Question, :count).by(0)
        end
      end
    end
  end

  describe "editing" do
    before(:each) do
      @question = create(:question)
      @answer_type = create(:answer_type)
    end
    let(:model_variable) { :question }
    let(:model_class) { Question }
    let(:model) { @question }
    let(:valid_model_parameters) {
      {
        label: "question_one",
        text: "Question",
        answer_type_id: @answer_type.id
      }
    }
    let(:invalid_model_parameters) {
      {
        label: "question number one",
        text: "Question",
        answer_type_id: @answer_type.id
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
            post 'update', id: @question.id,
              question: valid_model_parameters
          end
        end
        it "doesn't update the question" do
          expect {
            post 'update', id: @question.id,
              question: valid_model_parameters
          }.not_to change { @question }
        end
      end
    end
    context "as no one" do
      describe "update" do
        it_behaves_like "not logged in handler" do
          let!(:action) do
            post 'update', id: @question.id, question: valid_model_parameters
          end
        end
        it "doesn't update the question" do
          expect {
            post 'update', id: @question.id, question: valid_model_parameters
          }.not_to change { @question }
        end
      end
    end
  end

  describe "destroying" do
    before(:each) do
      @question = create(:question)
    end
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "destroyable ajax controller" do
        let(:model) { @question }
        let(:model_class) { Question }
        let(:resulting_page) { questions_path }
      end
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
      end
      it_behaves_like "unauthorized access handler" do
        let!(:action) do
          delete 'destroy', :id => @question.id
        end
      end
      it "does not delete anything" do
        expect {
          delete 'destroy', :id => @question.id
        }.not_to change { Question.count }
      end
    end
    context "as no one" do
      it_behaves_like "not logged in handler" do
        let!(:action) do
          delete 'destroy', :id => @question.id
        end
      end
      it "does not delete anything" do
        expect {
          delete 'destroy', :id => @question.id
        }.not_to change { Question.count }
      end
    end
  end
end
