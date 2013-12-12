class Role < ActiveRecord::Base
  # validations
  validates :role, presence: true, uniqueness: { case_sensitive: false }
  #associations
  has_many :users
end
