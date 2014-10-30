class User < ActiveRecord::Base
	#Associations
  belongs_to :role
	#Validations
	validates :email, presence: true, uniqueness: { case_sensitive: false }

  def self.create_with_omniauth(auth)
    create do |user|
      user.email = auth['info']['email']
      user.first_name = auth['info']['first_name']
      user.last_name = auth['info']['last_name']
    end
  end
end