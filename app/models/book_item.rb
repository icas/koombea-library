class BookItem < ActiveRecord::Base

  #Constants
  FORMATS = ['pdf', 'paper']

  #Associations
  belongs_to :book
  belongs_to :user

  #Validations
  validates :user, :book, presence: true
  validates :format, presence: true, inclusion: { in: FORMATS }
end
