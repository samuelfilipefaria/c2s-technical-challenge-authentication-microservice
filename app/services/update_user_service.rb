class UpdateUserService
  attr_accessor :id, :new_name, :new_email, :new_password 

  def initialize(id, new_name = nil, new_email = nil, new_password = nil)
    @id = id
    @new_name = new_name
    @new_email = new_email
    @new_password = new_password
  end

  def perform
    user = User.find(id)

    raise ArgumentError.new("Invalid user id!") unless user
    raise ArgumentError.new("Invalid arguments!") unless valid_parameters?

    user.update(
      name: new_name || user.name,
      email: new_email || user.email,
      password: new_password || user.password
    )
  end

  private

  def valid_parameters?
    valid_new_name? && valid_new_email? && valid_new_password?
  end

  def valid_new_name?
    valid_non_empty_string_parameter?(new_name, "new name")
  end

  def valid_new_email?
    raise ArgumentError.new("Invalid e-mail!") unless valid_non_empty_string_parameter?(new_email, "new e-mail")

    other_user_with_the_same_email = User.find_by(email: new_email)
    raise ArgumentError.new("Invalid e-mail!") if other_user_with_the_same_email && other_user_with_the_same_email.id != id

    true 
  end

  def valid_new_password?
    valid_non_empty_string_parameter?(new_password, "new password")
  end

  def valid_non_empty_string_parameter?(parameter, parameter_name)
    return true unless parameter

    parameter.strip!
    raise ArgumentError.new("Invalid #{parameter_name}!") if parameter.empty?

    true
  end
end
