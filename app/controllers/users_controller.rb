class UsersController < ActionController::API
  def send_response(message, code)
    render json: {APIresponse: message}, status: code
  end

  def send_response_with_token(message, code, user_token)
    render json: {APIresponse: message, token: user_token}, status: code
  end

  def send_response_with_name_and_email(message, code, user_name, user_email)
    render json: {APIresponse: message, name: user_name, email: user_email}, status: code
  end

  def api_message
    send_response("Hello! This is the microservice for AUTHENTICATION", 200)
  end

  def create
    new_user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )

    if new_user.save
      send_response("User created! Now log in.", 201)
    else
      send_response("Error creating user!", 500)
    end
  end

  def get_data
    user_data = JsonWebToken.decode_user_data(params[:token])
    user_id = user_data[0]["user_data"]

    user = User.find(user_id)

    if user
      send_response_with_name_and_email("User found!", 200, user.name, user.email)
    else
      send_response("User not found!", 404)
    end
  end

  def update
    user_data = JsonWebToken.decode_user_data(params[:token])
    user_id = user_data[0]["user_data"]

    user = User.find(user_id)

    unless user
      send_response("User not found!", 404)
      return
    end

    user.update(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )

    send_response("User updated!", 200)
  end

  def login
    user = User.where("email = ? AND password = ?", params[:email], params[:password]).first

    if user
      token = JsonWebToken.encode_user_data({ user_data: user.id })
      send_response_with_token("User logged in!", 200, token)
    else
      send_response("User not found!", 404)
    end
  end

  def destroy
    user_data = JsonWebToken.decode_user_data(params[:token])
    user_id = user_data[0]["user_data"]

    user = User.find(user_id)

    unless user
      send_response("User not found!", 404)
      return
    end

    user.destroy
    send_response("User deleted!", 200)
  end
end
