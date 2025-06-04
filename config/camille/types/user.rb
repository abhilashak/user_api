using Camille::Syntax

class Camille::Types::User < Camille::Type
  include Camille::Types

  alias_of(
    id: String,
    name: String,
    biography: String,
    created_at: String,
    updated_at: String
  )
end
