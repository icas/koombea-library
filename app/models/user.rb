class User < ActiveRecord::Base
	#Attributes
	#attr_reader :email

	#Associations

	#Validations
	validates :email, uniqueness: true, presence: true 
end