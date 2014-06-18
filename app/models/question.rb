class Question < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :text

  validates_presence_of :label
  validates :label, length: { maximum: 20 }
  validates :label, format: { with: /\A[a-zA-Z0-9_]+\z/ }
  validates :text, format: { with: /[\?]\z/ }

end
