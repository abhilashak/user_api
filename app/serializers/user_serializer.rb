# Handles serialization of User objects to JSON format
class UserSerializer
  # Serializes a user object into a hash with properly formatted timestamps
  # @param [User] user The user object to serialize
  # @return [Hash] A hash containing user attributes with formatted timestamps
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
