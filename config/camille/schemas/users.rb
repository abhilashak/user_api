using Camille::Syntax

class Camille::Schemas::Users < Camille::Schema
  include Camille::Types

  # GET /user - Get a random user
  get :show do
    response(User)
  end

  # POST /user - Create a new user
  post :create do
    params(
      name: String,
      biography: String
    )
    response(User | { error: String })
  end
end
