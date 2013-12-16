class Book < ActiveRecord::Base
	#Constants
	FORMATS = ['digital', 'paper']

	#Accessors
	#attr_accessor :title, :author_id, :editorial_id, :published_date, :format

	#Associations
	belongs_to :author
	belongs_to :editorial

	#Validations
	validates :title, :published_date, presence: true
	validates :format, presence: true, inclusion: { in: FORMATS }

	#Callbacks
	#
	def self.search(search)
		if search.blank?
			all
		else
			where("title like ?", "%#{search}%")
		end
	end
end