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
    # Get a random user efficiently using PostgreSQL's RANDOM()
    # Using OFFSET instead of ORDER BY RANDOM() for better performance with large datasets
    offset = rand(User.count)
    @user = User.offset(offset).first

    if @user
      render json: @user, status: :ok
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

    if !@user.valid?
      render json: { errors: @user.errors }, status: :unprocessable_entity
      return
    end

    # Simulate random failure 50% of the time
    if rand(2) == 1
      if @user.save
        render json: @user, status: :ok
      else
        render json: { errors: @user.errors }, status: :unprocessable_entity
      end
    else
      render json: { error: "Failed to save user (random failure simulation)" },
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :biography)
  end
end
