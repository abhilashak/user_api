class UuidController < ApplicationController
  # GET /id
  # Returns a new UUID v4
  # @return [JSON] Returns a JSON object containing a UUID v4 string
  # Example Response:
  #   { "id": "123e4567-e89b-12d3-a456-426614174000" }
  def show
    render json: { id: SecureRandom.uuid }, status: :ok
  end
end
