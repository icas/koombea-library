require 'spec_helper'

describe Author do
	subject{Author.new}
  
  #Attributes
	it { should respond_to(:name) }

  #Associations
	it {should have_many(:books) }

	#Validations
	it {  should validate_presence_of(:name) }

end