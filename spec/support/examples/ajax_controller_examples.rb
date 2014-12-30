def json_data_matches_attributes(response, attributes)
  json_response = JSON.parse response.body
  attributes.each do |key,value|
    if !key.to_s.ends_with? "_attributes"
      json_response[key.to_s].should == value
    end
  end
end

def json_data_has_errors(response)
  json_response = JSON.parse response.body
  json_response["errors"].should be
end

shared_examples "destroyable ajax controller" do
  describe "destroy" do
    it "returns true" do
      delete 'destroy', :id => model.id
      response.body.should == "true"
    end
    it "should delete the model" do
      expect {
        delete 'destroy', :id => model.id
      }.to change(model_class, :count).by(-1)
    end
  end
end

shared_examples "createable ajax controller" do
  describe "create" do
    describe "valid attributes" do
      it "creates a new model" do
        expect {
          post 'create', model_variable => valid_model_parameters
        }.to change(model_class, :count).by(1)
      end
      it "returns the created model" do
        post 'create', model_variable => valid_model_parameters
        json_data_matches_attributes(response, valid_model_parameters)
      end
    end
    describe "invalid attributes" do
      it "does not create a new model" do
        expect {
          post 'create', model_variable => invalid_model_parameters
        }.to_not change(model_class, :count).by(1)
      end
      it "returns the model errors" do
        post 'create', model_variable => invalid_model_parameters
        json_data_has_errors(response)
      end
    end
  end
end

shared_examples "editable ajax controller" do
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
      it "returns the model" do
        put 'update', :id => model.id, model_variable => valid_model_parameters
        json_data_matches_attributes(response, valid_model_parameters)
      end
    end
    describe "invalid attributes" do
      it "returns the model errors" do
        put 'update', :id => model.id, model_variable => invalid_model_parameters
        model.reload
        json_data_has_errors(response)
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
