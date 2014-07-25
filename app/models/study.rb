class Study < ActiveRecord::Base
  has_many :questionnaires, :dependent => :destroy

  validates_presence_of :title
  accepts_nested_attributes_for :questionnaires, 
    :reject_if => lambda { |a| a[:label].blank? },
    :allow_destroy => true

  self.per_page = 10
end
