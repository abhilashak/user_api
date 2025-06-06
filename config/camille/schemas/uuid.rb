using Camille::Syntax

class Camille::Schemas::Uuid < Camille::Schema
  include Camille::Types

  # GET /id - Returns UUID
  get :id do
    response(
      id: String
    )
  end
end
