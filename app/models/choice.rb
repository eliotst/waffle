class Choice < ActiveRecord::Base
  belongs_to :answer_type

  validates :value,
    presence: true,
    uniqueness: { scope: [ :answer_type ] }
  validates :text,
    presence: true,
    uniqueness: { scope: [ :answer_type ] }
  validates :order,
    presence: true,
    uniqueness: { scope: [ :answer_type ] }
end
