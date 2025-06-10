# Serializes User objects to Camille-compatible hash format
class UserSerializer
  # Serializes a user object to match Camille::Types::User format
  # @param [User] user The user object to serialize
  # @return [Hash] A hash matching Camille type definition
  def self.serialize(user)
    {
      id: user.id,
      name: user.name,
      biography: user.biography,
      created_at: user.created_at.iso8601,
      updated_at: user.updated_at.iso8601
    }
  end
end
