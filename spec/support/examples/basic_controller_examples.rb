shared_examples "showable controller" do
  describe "show" do
    it "returns http success" do
      get 'show', id: model.id
      response.should be_success
    end
    it "assigns model variable" do
      get 'show', id: model.id
      assigns(model_variable).should eq(model)
    end
    it "renders the show view" do
      get 'show', id: model.id
      response.should render_template :show
    end
  end
end

shared_examples "destroyable controller" do
  describe "destroy" do
    it "redirect to index" do
      delete 'destroy', :id => model.id
      response.should redirect_to resulting_page
    end
    it "should delete the model" do
      expect {
        delete 'destroy', :id => model.id
      }.to change(model_class, :count).by(-1)
    end
  end
end

shared_examples "indexable controller" do
  describe "index" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
    it "assigns model variables" do
      get 'index'
      assigns(list_variable).should eq(model_list)
    end
    it "renders the index view" do
      get :index
      response.should render_template :index
    end
  end
end

shared_examples "createable controller" do
  describe "new" do
    it "returns http success" do
      if defined?(new_params)
        get 'new', new_params
      else
        get 'new'
      end
      response.should be_success
    end
    it "assigns model" do
      if defined?(new_params)
        get 'new', new_params
      else
        get 'new'
      end
      assigns(model_variable).id.should == nil
    end
    it "renders the new view" do
      if defined?(new_params)
        get 'new', new_params
      else
        get 'new'
      end
      response.should render_template :new
    end
  end
  describe "create" do
    describe "valid attributes" do
      it "creates a new model" do
        expect {
          post 'create', model_variable => valid_model_parameters
        }.to change(model_class, :count).by(1)
      end
      it "redirects to the index view" do
        post 'create', model_variable => valid_model_parameters
        response.should redirect_to :action => :index
      end
    end
    describe "invalid attributes" do
      it "does not create a new model" do
        expect {
          post 'create', model_variable => invalid_model_parameters
        }.to_not change(model_class, :count).by(1)
      end
      it "rerenders the new view" do
        post 'create', model_variable => invalid_model_parameters
        response.should render_template :new
      end
    end
  end
end

shared_examples "editable controller" do
  describe "edit" do
    it "returns http success" do
      get 'edit', :id => model.id
      response.should be_success
    end
    it "assigns model" do
      get 'edit', :id => model.id
      assigns(model_variable).should == model
    end
    it "renders the new view" do
      get 'edit', :id => model.id
      response.should render_template :edit
    end
  end
  describe "update" do
    describe "valid attributes" do
      it "updates the model" do
        put 'update', :id => model.id, model_variable => valid_model_parameters
        model.reload
        valid_model_parameters.each do |key, value|
          if !value.is_a? Hash and !value.is_a? Array
            model.send(key).should == value
          end
        end
      end
      it "redirects to the show view" do
        put 'update', :id => model.id, model_variable => valid_model_parameters
        response.should redirect_to :action => :show
      end
    end
    describe "invalid attributes" do
      it "rerenders the edit view" do
        put 'update', :id => model.id, model_variable => invalid_model_parameters
        model.reload
        response.should render_template :edit
      end
      it "doesn't update the model" do
        put 'update', :id => model.id, model_variable => invalid_model_parameters
        model.reload
        same = true
        invalid_model_parameters.each do |key, value|
          if !value.is_a? Hash and !value.is_a? Array
            same = same and model.send(key) == value
          end
        end
        same.should be_true
      end
    end
  end
end

shared_examples "not logged in handler" do
  describe "on not logged in" do
    it "should redirect to the login page" do
      response.should redirect_to log_in_url
    end
  end
end

shared_examples "unauthorized access handler" do
  describe "on failed authentication" do
    it "should redirect to root" do
      response.should redirect_to root_url
    end
  end
end
