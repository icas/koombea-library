class Author < ActiveRecord::Base
	#Constants

	#Attributes
	#attr_accessor :name

	#Assoociations
	has_many(:books)

	#Validations
	validates :name, presence: true


end