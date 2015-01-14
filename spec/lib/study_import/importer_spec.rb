require 'spec_helper'

describe StudyImport::Importer, type: :request do
  before(:each) do
    data_filename = Rails.root.join("config", "study_data", "movie_example.yaml")
    yaml_data = File.read(data_filename)
    @admin_user = create(:admin)
    post sessions_path, email: @admin_user.email, password: "secret"
    @importer = StudyImport::Importer.new(yaml_data, self)
  end
  it "can load study data" do
    expect(@importer.config).to have_key('study')
  end
  describe "when importing the movie example data" do
    describe "for the studies" do
      it "creates the correct number" do
        expect(Study.count).to eq(1)
      end
      it "creates the movies study" do
        expect(Study.find_by_label("favorites")).to_not be_nil
      end
    end
    describe "for the questionnaires" do
      it "creates the correct number" do
        expect(Questionnaire.count).to eq(3)
      end
      it "creates the favorites questionnaire" do
        expect(Questionnaire.find_by_label("movie_favorites")).to_not be_nil
      end
      it "creates the favorites 2 questionnaire" do
        expect(Questionnaire.find_by_label("movie_favorites_2")).to_not be_nil
      end
    end
    describe "for the blocks" do
      it "creates the correct number" do
        expect(Block.count).to eq(3)
      end
      describe "actors block" do
        before(:each) do
          @block = Block.find_by_label!("actors")
        end
        it "creates the actors block" do
          expect(@block).to be
        end
        it "creates the actors block's questions" do
          expect(@block.questions.count).to eq(4)
        end
      end
      describe "genres block" do
        before(:each) do
          @block = Block.find_by_label!("genres")
        end
        it "creates the actors block" do
          expect(@block).to be
        end
        it "creates the actors block's questions" do
          expect(@block.questions.count).to eq(2)
        end
      end
      describe "movies block" do
        before(:each) do
          @block = Block.find_by_label!("movies")
        end
        it "creates the actors block" do
          expect(@block).to be
        end
        it "creates the actors block's questions" do
          expect(@block.questions.count).to eq(2)
        end
      end
    end
    describe "for the answer types" do
      it "creates the correct number"  do
        expect(AnswerType.count).to eq(4)
      end
      describe "move_genres answer type" do
        before(:each) do
          @answer_type = AnswerType.find_by_label!("movie_genres")
        end
        it "creates the answer type" do
          expect(@answer_type).to be
        end
        it "creates the answer type's choices" do
          expect(@answer_type.choices.count).to eq(4)
        end
      end
    end
    describe "for the questions" do
      it "creates the correct number" do
        expect(Question.count).to eq(8)
      end
    end
    describe "for the schedule templates" do
      it "creates the correct number" do
        expect(ScheduleTemplate.count).to eq(1)
      end
      it "creates the correct number of schedule template entries" do
        expect(ScheduleTemplateEntry.count).to eq(2)
      end
    end
  end
end
