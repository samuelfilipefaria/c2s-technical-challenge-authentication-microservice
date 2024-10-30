class LoginUserService
  attr_accessor :email, :password

  def initialize(email, password)
    @email = email
    @password = password
  end

  def perform
    user = User.where("email = ? AND password = ?", email, password).first

    raise ArgumentError.new("Invalid user id!") unless user

    puts "o id do service é"
      p user

    JsonWebToken.encode_user_data({ user_data: user.id })
  end
end
