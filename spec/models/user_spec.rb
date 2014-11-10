require 'spec_helper'

describe User do
	#Attributes
	it { should respond_to(:email, :first_name, :last_name ) }

	#Associations
  it { should belong_to(:role) }
	#Validations
	it { should validate_presence_of(:email) }

	describe "when the mail has already been taken" do
    before :each do
       role = Role.first
      @user = User.create(email: "user@koombea.com", role: role, first_name: "ric", last_name: "ber")
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when email is not in the company" do
    subject(:user){FactoryGirl.build(:user, email: 'email@koombea2.com')}
    it { should_not be_valid }
  end

  describe "when params are valid" do
    subject(:user){FactoryGirl.build(:user)}
    it { should be_valid }
  end
end