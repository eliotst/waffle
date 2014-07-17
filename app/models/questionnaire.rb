class Questionnaire < ActiveRecord::Base
has_many :blocks, :dependent => :destroy

  validates_presence_of :label
  accepts_nested_attributes_for :blocks, 
    :allow_destroy => true
end