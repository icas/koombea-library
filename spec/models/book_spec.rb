require 'spec_helper'

describe Book do
	subject{Book.new}

	#Attributes
	it { should respond_to(:title, :author_id, :editorial_id, :published_date, :format) }

	#Associations
	it { should belong_to(:author) }
	it { should belong_to(:editorial) }

	#Validations
	it {  should validate_presence_of(:title) }
	it {  should validate_presence_of(:published_date) }
	it {  should validate_presence_of(:format) }
	it {  should ensure_inclusion_of(:format).in_array(['digital', 'paper'])}
end