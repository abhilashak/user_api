class UsersController < ApplicationController
  # GET /user
  # Returns mock user details with id, name, and biography
  # @return [JSON] Returns a JSON object containing user details
  # Example Response:
  #   {
  #     "id": "123e4567-e89b-12d3-a456-426614174000",
  #     "name": "John Doe",
  #     "biography": "A software engineer with a passion for building great APIs"
  #   }
  def show
    # Simulate ~300ms response time as per requirements
    # Using 0.25 to account for Rails processing overhead
    sleep(0.25)

    render json: {
      id: SecureRandom.uuid,
      name: "John Doe",
      biography: "A software engineer with a passion for building great APIs"
    }, status: :ok
  end
end
