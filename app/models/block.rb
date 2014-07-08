class Block < ActiveRecord::Base
  has_many :questions, :dependent => :destroy

  validates_presence_of :label
  accepts_nested_attributes_for :questions
end
