require 'spec_helper'

describe Study do
  it "has a valid factory" do
    create(:study).should be_valid
  end
  it "should be invalid without any title" do
    build(:study, title: nil).should_not be_valid
  end
  it "should be invalid without a unique title" do
    create(:study, title: 'Study')
    build(:study, title: 'Study').should_not be_valid
  end
  it_behaves_like "a model with a label" do
    let(:model_factory) { :study }
  end
  describe "destroy" do
    it "destroys the questionnaires" do
      study = create(:study_with_questionnaires)
      study.destroy
      Questionnaire.count.should == 0
    end
    it "destroys the schedule templates" do
      study = create(:study_with_schedule_templates)
      study.destroy
      ScheduleTemplate.count.should == 0
    end
  end
end
