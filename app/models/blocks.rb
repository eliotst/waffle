class Blocks < ActiveRecord::Base
  has_many :questions

  validates_presence_of :label
end
