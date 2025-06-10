class ApplicationController < ActionController::API
  private

  # Renders validation errors with unprocessable entity status
  # @param [ActiveRecord::Base] resource The resource with validation errors
  def validation_error(resource = nil)
    resource ||= @resource
    # Convert validation errors to single error message for Camille compatibility
    error_messages = resource.errors.full_messages.join(", ")
    render json: { error: error_messages }, status: :unprocessable_entity
  end

  # Renders a random failure response for simulation purposes
  # @return [JSON] Returns error message with unprocessable entity status
  def random_failure
    render json: { error: "Failed to save user (random failure simulation)" },
           status: :unprocessable_entity
  end

  # Simulates a failure with 50% probability
  # @return [Boolean] Returns true if failure should be simulated
  def simulate_failure?
    rand(2) == 1
  end
end
