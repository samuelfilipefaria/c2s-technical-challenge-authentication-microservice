class UsersController < ActionController::API
  def send_response(message)
    render json: {APIresponse: message}
  end

  def api_message
    send_response("Olá! Este é o microserviço para AUTENTICAÇÃO")
  end

  def create
    new_user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )

    if new_user.save
      send_response("Usuário criado! Agora faça login.")
    else
      send_response("Erro ao criar usuário!")
    end
  end

  def get_data
    user_data = JsonWebToken.decode_user_data(params[:token])
    user_id = user_data[0]["user_data"]

    user = User.find(user_id)

    if user
      render json: {APIresponse: "Usuário encontrado!", name: user.name, email: user.email}
    else
      send_response("Usuário não encontrado!")
    end
  end

  def update
    user = User.find(params[:id])

    unless user
      send_response("Usuário não encontrado!")
      return
    end

    user.update(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )
  end

  def login
    user = User.where("email = ? AND password = ?", params[:email], params[:password]).first

    if user
      token = JsonWebToken.encode_user_data({ user_data: user.id })
      render json: {APIresponse: "Usuário logado!", token: token}
    else
      send_response("Usuário não encontrado!")
    end
  end

  def destroy
    user_data = JsonWebToken.decode_user_data(params[:token])
    user_id = user_data[0]["user_data"]

    user = User.find(user_id)

    unless user
      send_response("Usuário não encontrado!")
      return
    end

    user.destroy
  end
end
