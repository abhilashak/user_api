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
end
