class User < ActiveRecord::Base
	#Associations
  belongs_to :role
	#Validations
	validates :email, presence: true, uniqueness: { case_sensitive: false }

  def self.create_with_omniauth(auth)
    create! do |user|
      user.email = auth['info']['email']
      user.first_name = auth['info']['first_name']
      user.last_name = auth['info']['last_name']
      user.role_id = Role.find_by_account_type("user").id
    end
  end

  def have_the_role?(account_type)
    role.account_type == account_type.to_s
  end
end