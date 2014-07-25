class Questionnaire < ActiveRecord::Base
  has_many :blocks, :dependent => :destroy
  belongs_to :study

  validates_presence_of :label
  accepts_nested_attributes_for :blocks,
    :reject_if => lambda { |a| a[:label].blank? },
    :allow_destroy => true

  self.per_page = 10
end