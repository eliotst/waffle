require 'spec_helper'

describe ScheduleTemplatesController, type: :controller do
  before(:each) do
    @admin_user = create(:admin)
    @regular_user = create(:user)
  end

  describe "creating" do
    before(:each) do
      @study = create(:study)
      @questionnaire = create(:questionnaire)
    end
    let(:valid_model_parameters) {
      {
        study_id: @study.id,
        schedule_template_entries_attributes: [
          {
            questionnaire_id: @questionnaire.id,
            time_offset_hours: 24
          }
        ]
      }
    }
    let(:invalid_model_parameters) {
      {
        study_id: @study.id,
        schedule_template_entries_attributes: [
          {
            questionnaire_id: @questionnaire.id,
            time_offset_hours: -24
          }
        ]
      }
    }
    context "as an admin" do
      let(:model_variable) { :schedule_template }
      let(:model_class) { ScheduleTemplate }
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "createable ajax controller"
        it_behaves_like "createable with nested attributes controller" do
          let(:child_class) { ScheduleTemplateEntry }
          let(:number_of_children) { 1 }
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
        it "doesn't create a new schedule_template" do
          expect {
            post 'create', valid_model_parameters
          }.to change(ScheduleTemplate, :count).by(0)
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
        it "doesn't create a new schedule_template" do
          expect {
            post 'create', valid_model_parameters
          }.to change(ScheduleTemplate, :count).by(0)
        end
      end
    end
  end

  describe "editing" do
    before(:each) do
      @study = create(:study)
      @questionnaire = create(:questionnaire)
      @schedule_template = create(:schedule_template)
    end
    let(:model_variable) { :schedule_template }
    let(:model_class) { ScheduleTemplate }
    let(:model) { @schedule_template }
    let(:valid_model_parameters) {
      {
        study_id: @study.id,
        schedule_template_entries_attributes: [
          {
            questionnaire_id: @questionnaire.id,
            time_offset_hours: 24
          }
        ]
      }
    }
    let(:invalid_model_parameters) {
      {
        study_id: @study.id,
        schedule_template_entries_attributes: [
          0 => {
            questionnaire_id: @questionnaire.id,
            time_offset_hours: -24
          }
        ]
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
            post 'update', id: @schedule_template.id, schedule_template: valid_model_parameters
          end
        end
        it "doesn't update the schedule_template" do
          expect {
            post 'update', id: @schedule_template.id,
              schedule_template: valid_model_parameters
          }.not_to change { @schedule_template }
        end
      end
    end
    context "as no one" do
      describe "update" do
        it_behaves_like "not logged in handler" do
          let!(:action) do
            post 'update', id: @schedule_template.id, schedule_template: valid_model_parameters
          end
        end
        it "doesn't update the schedule_template" do
          expect {
            post 'update', id: @schedule_template.id, schedule_template: valid_model_parameters
          }.not_to change { @schedule_template }
        end
      end
    end
  end

  describe "destroying" do
    before(:each) do
      @schedule_template = create(:schedule_template)
    end
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "destroyable ajax controller" do
        let(:model) { @schedule_template }
        let(:model_class) { ScheduleTemplate }
        let(:resulting_page) { schedule_templates_path }
      end
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
      end
      it_behaves_like "unauthorized access handler" do
        let!(:action) do
          delete 'destroy', :id => @schedule_template.id
        end
      end
      it "does not delete anything" do
        expect {
          delete 'destroy', :id => @schedule_template.id
        }.not_to change { ScheduleTemplate.count }
      end
    end
    context "as no one" do
      it_behaves_like "not logged in handler" do
        let!(:action) do
          delete 'destroy', :id => @schedule_template.id
        end
      end
      it "does not delete anything" do
        expect {
          delete 'destroy', :id => @schedule_template.id
        }.not_to change { ScheduleTemplate.count }
      end
    end
  end
end
