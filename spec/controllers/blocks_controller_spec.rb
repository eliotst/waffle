require 'spec_helper'

describe BlocksController, type: :controller do
  before(:each) do
    @admin_user = create(:user, admin: true)
    @regular_user = create(:user)
  end
  describe "showing" do
    before(:each) do
      @block = create(:block)
    end
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "showable controller" do
        let(:model) { @block }
        let(:model_variable) { :block }
      end
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
      end
      it_behaves_like "unauthorized access handler" do
        let!(:action) do
          get 'show', id: @block.id
        end
      end
    end
    context "as no one" do
      it_behaves_like "not logged in handler" do
        let!(:action) { get :show, id: @block.id }
      end
    end
  end

  describe "creating" do
    let(:valid_model_parameters) {
      {
        label: "block_one"
      }
    }
    let(:invalid_model_parameters) {
      {
        label: "block number one"
      }
    }
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "createable controller" do
        let(:model_variable) { :block }
        let(:model_class) { Block }
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
        it "doesn't create a new block" do
          expect {
            post 'create', valid_model_parameters
          }.to change(Block, :count).by(0)
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
        it "doesn't create a new block" do
          expect {
            post 'create', valid_model_parameters
          }.to change(Block, :count).by(0)
        end
      end
    end
  end

  describe "editing" do
    before(:each) do
      @block = create(:block)
    end
    let(:model_variable) { :block }
    let(:model_class) { Block }
    let(:model) { @block }
    let(:valid_model_parameters) {
      {
        label: "block_one"
      }
    }
    let(:invalid_model_parameters) {
      {
        label: "block number one"
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
            get 'edit', id: @block.id
          end
        end
      end
      describe "update" do
        it_behaves_like "unauthorized access handler" do
          let!(:action) do
            get 'edit', id: @block.id
          end
        end
        it "doesn't update the study" do
          expect {
            post 'update', id: @block.id,
              study: valid_model_parameters
          }.not_to change { @block }
        end
      end
    end
    context "as no one" do
      describe "edit" do
        it_behaves_like "not logged in handler" do
          let!(:action) do
            get 'edit', id: @block.id
          end
        end
      end
      describe "update" do
        it_behaves_like "not logged in handler" do
          let!(:action) do
            post 'update', id: @block.id, block: valid_model_parameters
          end
        end
        it "doesn't update the study" do
          expect {
            post 'update', id: @block.id, block: valid_model_parameters
          }.not_to change { @block }
        end
      end
    end
  end

  describe "indexing" do
    before(:each) do
      @block_one = create(:block)
      @block_two = create(:block)
      @blocks = [ @block_one, @block_two ]
    end
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "indexable controller" do
        let(:model_list) { @blocks }
        let(:list_variable) { :blocks }
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
      @block = create(:block)
    end
    context "as an admin" do
      before(:each) do
        log_in(@admin_user)
      end
      it_behaves_like "destroyable controller" do
        let(:model) { @block }
        let(:model_class) { Block }
        let(:resulting_page) { blocks_path }
      end
    end
    context "as a regular user" do
      before(:each) do
        log_in(@regular_user)
      end
      it_behaves_like "unauthorized access handler" do
        let!(:action) do
          delete 'destroy', :id => @block.id
        end
      end
      it "does not delete anything" do
        expect {
          delete 'destroy', :id => @block.id
        }.not_to change { Block.count }
      end
    end
    context "as no one" do
      it_behaves_like "not logged in handler" do
        let!(:action) do
          delete 'destroy', :id => @block.id
        end
      end
      it "does not delete anything" do
        expect {
          delete 'destroy', :id => @block.id
        }.not_to change { Block.count }
      end
    end
  end
end
