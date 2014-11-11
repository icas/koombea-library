class BookItem < ActiveRecord::Base

  #Constants
  FORMATS = ['digital', 'paper']

  #Associations
  belongs_to :book
  belongs_to :user

  #Validations
  validates :user, :book, presence: true
  validates :format, presence: true, inclusion: { in: FORMATS }
end
