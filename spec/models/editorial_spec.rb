require 'spec_helper'

describe Editorial do
	subject{Editorial.new}

	#Attributes
	it { should respond_to(:name) }

	#Associations
	it {should have_many(:books) }

	#Validations
	it {  should validate_presence_of(:name) }
end