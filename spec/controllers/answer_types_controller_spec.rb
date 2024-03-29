require 'spec_helper'

describe AnswerTypesController, type: :controller do
  before(:each) do
    @admin_user = create(:admin)
    @regular_user = create(:user)
  end

  describe "creating" do
    let(:model_variable) { :answer_type }
    let(:model_class) { AnswerType }
    let(:valid_model_parameters) {
      {
        label: "1234",
        description: "foo",
        choices_attributes: [
          {
            value: "1",
            text: "one",
            order: 1
          },
          {
            value: "2",
            text: "two",
            order: 2
          }
        ]
      }
    }
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      describe "choices" do
        let(:invalid_model_parameters) {
          {
            label: "1234",
            description: "foo",
            choices_attributes: [
              {
                value: "1",
                text: "one",
                order: 1
              },
              {
                value: "2",
                text: "two"
              }
            ]
          }
        }
        it_behaves_like "createable ajax controller" 
        it_behaves_like "createable with nested attributes controller" do
          let(:model_variable) { :answer_type }
          let(:child_class) { Choice }
          let(:number_of_children) { 2 }
        end
      end
      describe "answer validations" do
        let(:valid_model_parameters) {
          {
            label: "1234",
            description: "foo",
            answer_validation_attributes: 
              {
                regular_expression: "one",
              }
          }
        }
        let(:invalid_model_parameters) {
          {
            value: "1234",
            description: "foo",
            answer_validation_attributes: 
              {
                foo: "1234"
              }
          }
        }
        it_behaves_like "createable ajax controller"
        it_behaves_like "createable with nested attributes controller" do
          let(:model_variable) { :answer_type }
          let(:child_class) { AnswerValidation }
          let(:number_of_children) { 1 }
        end
      end
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
      end
      describe "create" do
        it_behaves_like "unauthorized access handler" do
          let!(:action) do
            post :create, valid_model_parameters
          end
        end
        it "doesn't create a new answer type" do
          expect {
            post 'create', valid_model_parameters
          }.to change(Study, :count).by(0)
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
        it "doesn't create a new answer type" do
          expect {
            post 'create', valid_model_parameters
          }.to change(Study, :count).by(0)
        end
      end
    end
  end

  describe "editing" do
    before(:each) do
      @answer_type = create(:true_false_choice_answer_type)
      @true_choice_id = @answer_type.choices[0].id
      @false_choice_id = @answer_type.choices[1].id
    end
    let(:valid_model_parameters) {
      {
        label: "1234",
        description: "foo",
        choices_attributes: [
          {
            id: @true_choice_id,
            value: "1",
            text: "one",
            order: 1
          },
          {
            id: @false_choice_id,
            value: "2",
            text: "two",
            order: 2
          }
        ]
      }
    }
    let(:model_variable) { :answer_type }
    let(:model_class) { AnswerType }
    let(:model) { @answer_type }
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      describe "choices" do
        let(:invalid_model_parameters) {
          {
            label: "!@#",
            description: "foo",
            choices_attributes: [
              {
                id: @true_choice_id,
                value: "1",
                text: "one",
                order: 1
              },
              {
                id: @false_choice_id,
                value: "2",
                text: "two"
              }
            ]
          }
        }
        it_behaves_like "editable ajax controller"
      end
      describe "answer validations" do
        before(:each) do
          @answer_type = create(:answer_type)
        end
        let(:valid_model_parameters) {
          {
            label: "1234",
            description: "foo",
            answer_validation_attributes: 
              {
                regular_expression: "one"
              }
          }
        }
        let(:invalid_model_parameters) {
          {
            label: "1234",
            description: nil,
            answer_validation_attributes: 
              {
                regular_expression: "one"
              }
          }
        }
        it_behaves_like "editable ajax controller"
      end
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
      end
      describe "update" do
        it_behaves_like "unauthorized access handler" do
          let!(:action) do
            post 'update', id: @answer_type.id, answer_type: valid_model_parameters
          end
        end
        it "doesn't update the answer type" do
          expect {
            post 'update', id: @answer_type.id,
              answer_type: valid_model_parameters
          }.not_to change { @answer_type }
        end
      end
    end
    context "as no one" do
      describe "update" do
        it_behaves_like "not logged in handler" do
          let!(:action) do
            post 'update', id: @answer_type.id, answer_type: valid_model_parameters
          end
        end
        it "doesn't update the answer type" do
          expect {
            post 'update', id: @answer_type.id, answer_type: valid_model_parameters
          }.not_to change { @answer_type }
        end
      end
    end
  end

  describe "destroying" do
    before(:each) do
      @answer_type = create(:answer_type)
    end
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "destroyable ajax controller" do
        let(:model) { @answer_type }
        let(:model_class) { AnswerType }
        let(:resulting_page) { answer_types_path }
      end
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
      end
      it_behaves_like "unauthorized access handler" do
        let!(:action) do
          delete 'destroy', :id => @answer_type.id
        end
      end
      it "does not delete anything" do
        expect {
          delete 'destroy', :id => @answer_type.id
        }.not_to change { AnswerType.count }
      end
    end
    context "as no one" do
      it_behaves_like "not logged in handler" do
        let!(:action) do
          delete 'destroy', :id => @answer_type.id
        end
      end
      it "does not delete anything" do
        expect {
          delete 'destroy', :id => @answer_type.id
        }.not_to change { AnswerType.count }
      end
    end
  end
end
