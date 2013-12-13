class Role < ActiveRecord::Base
  # validations
  validates :account_type, presence: true, uniqueness: { case_sensitive: false }
  #associations
  has_many :users
end
