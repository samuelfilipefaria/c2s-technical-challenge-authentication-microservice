class GetUserDataService
  attr_accessor :id

  def initialize(id)
    @id = id
  end

  def perform
    user = User.find(id)

    raise ArgumentError.new("Invalid user id!") unless user

    user
  end
end
