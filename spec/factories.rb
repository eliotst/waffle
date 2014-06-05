require 'faker'
#************** Validations for User *********************
#
#  validates :email, presence: true, length: { in: 6..80}, 
#    format: { with: VALID_EMAIL_REGEX }, 
#    uniqueness: { case_sensitive: false }
#  validates_presence_of :password, :on => :create
#  validates_presence_of :password_confirmation
#  validates_confirmation_of :password
#  validates :password, length: { minimum: 5 }

FactoryGirl.define do 
  factory :user do |f| 
    f.email { |n| "person_#{n}@example.com" }
    f.password "foobar" 
    f.password_confirmation "foobar"
  end
  factory :admin do
    admin true
  end 
end