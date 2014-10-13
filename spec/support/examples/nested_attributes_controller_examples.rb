shared_examples "createable with nested attributes controller" do
  describe "valid attributes" do
    it "should create the child class" do
        expect {
          post 'create', model_variable => valid_model_parameters
        }.to change(child_class, :count).by(number_of_children)
    end
  end
  describe "invalid attributes" do
    it "should not create the child class" do
        expect {
          post 'create', model_variable => invalid_model_parameters
        }.to change(child_class, :count).by(0)
    end
  end
end

shared_examples "editable with nested attributes controller" do
  describe "valid attributes" do
    it "should update the child class" do
      put 'update', :id => model.id, model_variable => valid_model_parameters
      model.reload
      valid_model_parameters.each do |key, value|
        if value.is_a?(Hash) && key.to_s.ends_with?('attributes')
          value.each do |child_key, child_value|
            model.send(key[0..-12]).send(child_key).should == child_value
          end
        end
      end
    end
  end
  describe "invalid attributes" do
    it "should not update the child class" do
      old_attributes = model.send(child_variable).attributes
      put 'update', :id => model.id, model_variable => invalid_model_parameters
      model.reload
      old_attributes.each do |key, value|
        model.send(child_variable).send(key).should == value
      end
     end
  end
end
