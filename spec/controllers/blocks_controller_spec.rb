require 'spec_helper'

describe BlocksController, type: :controller do
  before(:each) do
    @admin_user = create(:admin)
    @regular_user = create(:user)
  end

  describe "creating" do
    let(:valid_model_parameters) {
      {
        label: "block_one",
      }
    }
    let(:invalid_model_parameters) {
      {
        label: "block number one",
      }
    }
    context "as an admin" do
      let(:model_variable) { :block }
      let(:model_class) { Block }
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
        it "doesn't create a new block" do
          expect {
            post 'create', valid_model_parameters
          }.to change(Block, :count).by(0)
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
        label: "block_one",
      }
    }
    let(:invalid_model_parameters) {
      {
        label: "block number one",
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
            post 'update', id: @block.id, block: valid_model_parameters
          end
        end
        it "doesn't update the block" do
          expect {
            post 'update', id: @block.id,
              block: valid_model_parameters
          }.not_to change { @block }
        end
      end
    end
    context "as no one" do
      describe "update" do
        it_behaves_like "not logged in handler" do
          let!(:action) do
            post 'update', id: @block.id, block: valid_model_parameters
          end
        end
        it "doesn't update the block" do
          expect {
            post 'update', id: @block.id, block: valid_model_parameters
          }.not_to change { @block }
        end
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
      it_behaves_like "destroyable ajax controller" do
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
