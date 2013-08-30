class BookExemplary < ActiveRecord::Base
	#Attributes
	#attr_accessor :owner_id, :book_id

	#Associations
	belongs_to :book
	belongs_to :owner, class_name: "User"
end