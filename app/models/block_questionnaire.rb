class BlockQuestionnaire < ActiveRecord::Base
  belongs_to :block
  belongs_to :questionnaire
end
