class Book < ActiveRecord::Base
	
	#Accessors
	#attr_accessor :title, :author_id, :editorial_id, :published_date, :format

	#Associations
	belongs_to :author
	belongs_to :editorial

	#Validations
	validates :title, :published_date, presence: true


	#Callbacks
end