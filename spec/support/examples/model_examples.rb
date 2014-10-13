shared_examples "a model with a label" do
  it "should be invalid with a label that is too long" do
    build(model_factory, label: "1" * 40).should_not be_valid
  end
  it "should be invalid if the label has spaces" do
    build(model_factory, label: "invalid label").should_not be_valid
  end
  it "should be invalid if it is not alphanumeric only" do
    build(model_factory, label: "invalid!").should_not be_valid
  end
  it "should be invalid if not unique" do
    create(model_factory, label: "foo")
    build(model_factory, label: "foo").should_not be_valid
  end
end
