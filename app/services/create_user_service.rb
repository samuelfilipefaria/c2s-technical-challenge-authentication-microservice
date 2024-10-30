class CreateUserService
  attr_accessor :name, :email, :password 

  def initialize(name, email, password)
    @name = name
    @email = email
    @password = password
  end

  def perform
    raise ArgumentError.new("Invalid arguments!") unless valid_parameters?

    User.create(
      name: name,
      email: email,
      password: password
    )
  end

  private

  def valid_parameters?
    valid_name? && valid_email? && valid_password?
  end

  def valid_name?
    valid_non_empty_string_parameter?(name, "name")
  end

  def valid_email?
    raise ArgumentError.new("Invalid e-mail!") unless valid_non_empty_string_parameter?(email, "e-mail")

    other_user_with_the_same_email = User.find_by(email: email)
    raise ArgumentError.new("Invalid e-mail!") if other_user_with_the_same_email

    true 
  end

  def valid_password?
    valid_non_empty_string_parameter?(password, "password")
  end

  def valid_non_empty_string_parameter?(parameter, parameter_name)
    raise ArgumentError.new("Invalid #{parameter_name}!") unless parameter

    parameter.strip!
    raise ArgumentError.new("Invalid #{parameter_name}!") if parameter.empty?

    true
  end
end
