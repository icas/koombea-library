class Editorial < ActiveRecord::Base
	#Attributes
	#attr_accessor :name

	#Associations
	has_many :books

	#Validations
	validates :name, presence: true
	
	#Callbacks
end