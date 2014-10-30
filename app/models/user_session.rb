class UserSession
  attr_reader :user_id

  def self.storage=(session_storage)
    @@session_storage = session_storage
  end

  def self.current_user=(user)
    @@session_storage[:user_id] = user.id
  end

  def self.current
    if @@session_storage[:user_id]
      self.new(@@session_storage[:user_id])
    end
  end

  def self.destroy_current
    @@session_storage[:user_id] = nil
  end

  def initialize(user_id)
    @user_id = user_id
  end
end