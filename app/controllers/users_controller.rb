class UsersController < ActionController::API
  def send_response(message, code)
    render json: {APIresponse: message}, status: code
  end

  def send_response_with_token(message, code, user_token)
    render json: {APIresponse: message, token: user_token}, status: code
  end

  def send_response_with_id(message, code, user_id)
    render json: {APIresponse: message, userId: user_id}, status: code
  end

  def send_response_with_name_and_email(message, code, user_name, user_email)
    render json: {APIresponse: message, name: user_name, email: user_email}, status: code
  end

  def api_message
    send_response("Hello! This is the microservice for AUTHENTICATION", 200)
  end

  def is_given_token_valid(given_token)
    user_id = JsonWebToken.get_user_id(given_token)
    user = User.find(user_id)

    return true if user
    false
  end

  def authorize_user
    send_response("Token is invalid! User not found!", 404) unless is_given_token_valid(params[:token])
  end

  def create
    service = CreateUserService.new(params[:name], params[:email], params[:password])

    if service.perform
      send_response("User created! Now log in.", 201)
    else
      send_response("Error creating user!", 500)
    end
  end

  def get_data
    service = GetUserDataService.new(JsonWebToken.get_user_id(params[:token]))
    user = service.perform
    
    if user
      send_response_with_name_and_email("User found!", 200, user.name, user.email)
    else
      send_response("User not found!", 404)
    end
  end

  def get_data_by_id
    authorize_user
    
    service = GetUserDataService.new(params[:user_id])
    user = service.perform
    
    if user
      send_response_with_name_and_email("User found!", 200, user.name, user.email)
    else
      send_response("User not found!", 404)
    end
  end

  def get_id
    service = GetUserDataService.new(JsonWebToken.get_user_id(params[:token]))
    user = service.perform
    
    if user
      send_response_with_id("User found!", 200, user.id)
    else
      send_response("User not found!", 404)
    end
  end

  def update
    service = UpdateUserService.new(
      JsonWebToken.get_user_id(params[:token]),
      params[:name],
      params[:email],
      params[:password]
    )

    if service.perform
      send_response("User updated!", 200)
    else
      send_response("Error updating user!", 500)
    end    
  end

  def destroy
    service = DeleteUserService.new(
      JsonWebToken.get_user_id(params[:token])
    )

    user_token = service.perform

    if service.perform
      send_response("User deleted!", 200)
    else
      send_response("Error deleting user!", 500)
    end  
  end

  def login
    service = LoginUserService.new(
      params[:email],
      params[:password]
    )

    user_token = service.perform

    if user_token
      send_response_with_token("User logged in!", 200, user_token)
    else
      send_response("User not found!", 404)
    end  
  end
end
