class Block < ActiveRecord::Base
  has_many :questions, :dependent => :destroy
  belongs_to :questionnaire

  validates_presence_of :label
  accepts_nested_attributes_for :questions, 
  	:reject_if => lambda { |a| a[:text].blank? },
  	:allow_destroy => true

  self.per_page = 10
end
