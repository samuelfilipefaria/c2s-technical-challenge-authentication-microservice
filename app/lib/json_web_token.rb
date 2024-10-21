class JsonWebToken
  SECRET = "yoursecretword"

  def self.authentication
    decoded_data = decode_user_data(request.headers["token"])
    user_data = decoded_data[0]["user_id"] unless !decoded_data
    user = User.find(user_data&.id)

    if user
      return true
    else
      render json: { message: "invalid credentials" }
    end
  end

  def self.encode_user_data(user_data)
    token = JWT.encode user_data, SECRET, "HS256"
    return token
  end

  def self.decode_user_data(token)
    begin
      user_data = JWT.decode token, SECRET
      return user_data
    rescue => e
      puts e
    end
  end
end
