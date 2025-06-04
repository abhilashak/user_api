class UsersController < ApplicationController
  # GET /user
  # Returns a random user's details from the database
  # @return [JSON] Returns a JSON object containing user details
  # Example Response:
  #   {
  #     "id": "123e4567-e89b-12d3-a456-426614174000",
  #     "name": "John Doe",
  #     "biography": "Full-stack developer..."
  #   }
  def show
    @user = User.random_user

    if @user
      render json: UserSerializer.serialize(@user), status: :ok
    else
      render json: { error: "No users found" }, status: :not_found
    end
  end

  # POST /user
  # Creates a new user with 50% chance of success
  # @param [String] name User's name
  # @param [String] biography User's biography
  # @return [JSON] Returns the created user or error message
  def create
    @user = User.new(user_params)

    return validation_error(@user) unless @user.valid?
    return random_failure if simulate_failure?

    if @user.save
      render json: UserSerializer.serialize(@user), status: :ok
    else
      validation_error(@user)
    end
  end

  private

  def user_params
    params.permit(:name, :biography)
  end
end
