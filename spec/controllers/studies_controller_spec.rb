require 'spec_helper'

describe StudiesController, type: :controller do
  before(:each) do
    @admin_user = create(:user, admin: true)
    @regular_user = create(:user)
  end
  describe "showing" do
    before(:each) do
      @study = create(:study)
    end
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "showable controller" do
        let(:model) { @study }
        let(:model_variable) { :study }
      end
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
      end
      it_behaves_like "showable controller" do
        let(:model) { @study }
        let(:model_variable) { :study }
      end
    end
    context "as no one" do
      it_behaves_like "not logged in handler" do
        let!(:action) { get :show, id: @study.id }
      end
    end
  end

  describe "creating" do
    let(:valid_model_parameters) {
      {
        title: "The Greatest Study Every",
        label: "study_one"
      }
    }
    let(:invalid_model_parameters) {
      {
        title: "The Greatest Study Every",
        label: "study number one"
      }
    }
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "createable controller" do
        let(:model_variable) { :study }
        let(:model_class) { Study }
      end
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
      end
      describe "new" do
        it_behaves_like "unauthorized access handler" do
          let!(:action) do
            get :new
          end
        end
      end
      describe "create" do
        it_behaves_like "unauthorized access handler" do
          let!(:action) do
            post :create, valid_model_parameters
          end
        end
        it "doesn't create a new study" do
          expect {
            post 'create', valid_model_parameters
          }.to change(Study, :count).by(0)
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
        it "doesn't create a new study" do
          expect {
            post 'create', valid_model_parameters
          }.to change(Study, :count).by(0)
        end
      end
    end
  end

  describe "editing" do
    before(:each) do
      @study = create(:study)
    end
    let(:model_variable) { :study }
    let(:model_class) { Study }
    let(:model) { @study }
    let(:valid_model_parameters) {
      {
        title: "The Greatest Study Every",
        label: "study_one"
      }
    }
    let(:invalid_model_parameters) {
      {
        title: "The Greatest Study Every",
        label: "study number one"
      }
    }
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "editable controller"
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
      end
      describe "edit" do
        it_behaves_like "unauthorized access handler" do
          let!(:action) do
            get 'edit', id: @study.id
          end
        end
      end
      describe "update" do
        it_behaves_like "unauthorized access handler" do
          let!(:action) do
            get 'edit', id: @study.id
          end
        end
        it "doesn't update the study" do
          expect {
            post 'update', id: @study.id,
              study: valid_model_parameters
          }.not_to change { @study }
        end
      end
    end
    context "as no one" do
      describe "edit" do
        it_behaves_like "not logged in handler" do
          let!(:action) do
            get 'edit', id: @study.id
          end
        end
      end
      describe "update" do
        it_behaves_like "not logged in handler" do
          let!(:action) do
            post 'update', id: @study.id, study: valid_model_parameters
          end
        end
        it "doesn't update the study" do
          expect {
            post 'update', id: @study.id, study: valid_model_parameters
          }.not_to change { @study }
        end
      end
    end
  end

  describe "indexing" do
    before(:each) do
      @study_one = create(:study)
      @study_two = create(:study)
      @studies = [ @study_one, @study_two ]
    end
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "indexable controller" do
        let(:model_list) { @studies }
        let(:list_variable) { :studies }
      end
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
      end
      it_behaves_like "indexable controller" do
        let(:model_list) { @studies }
        let(:list_variable) { :studies }
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
      @study = create(:study)
    end
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "destroyable controller" do
        let(:model) { @study }
        let(:model_class) { Study }
        let(:resulting_page) { studies_path }
      end
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
      end
      it_behaves_like "unauthorized access handler" do
        let!(:action) do
          delete 'destroy', :id => @study.id
        end
      end
      it "does not delete anything" do
        expect {
          delete 'destroy', :id => @study.id
        }.not_to change { Study.count }
      end
    end
    context "as no one" do
      it_behaves_like "not logged in handler" do
        let!(:action) do
          delete 'destroy', :id => @study.id
        end
      end
      it "does not delete anything" do
        expect {
          delete 'destroy', :id => @study.id
        }.not_to change { Study.count }
      end
    end
  end
end
