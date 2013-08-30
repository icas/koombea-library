require 'spec_helper'

describe User do
	subject{User.new}

	#Attributes
	it { should respond_to(:email, :first_name, :last_name ) }

	#Associations

	#Validations
	it{should validate_presence_of(:email) }
	it{should validate_uniqueness_of(:email) }
end