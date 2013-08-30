require 'spec_helper'

describe User do
	subject{User.new}

	describe "attributes" do
		it { should respond_to(:email) }
	end
end