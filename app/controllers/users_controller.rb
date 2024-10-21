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
      send_response("Usuário criado: #{new_user}")
    else
      send_response("Erro ao criar usuário!")
    end
  end

  def show
    user = User.find(params[:id])

    if user
      send_response("Usuário encontrado: #{user}")
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
      send_response("Usuário encontrado: #{user}")
    else
      send_response("Usuário não encontrado!")
    end
  end

  def destroy
    user = User.find(params[:id])

    unless user
      send_response("Usuário não encontrado!")
      return
    end

    user.destroy
  end
end