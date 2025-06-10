module UuidHelpers
  # UUID v4 regex pattern (more specific, validates version 4 UUIDs)
  UUID_V4_REGEX = /^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/

  # General UUID regex pattern (less specific, matches any UUID format)
  UUID_REGEX = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/

  # Asserts that a value is a valid UUID v4
  # @param [String] value The UUID string to validate
  # @param [String] message Optional custom error message
  def assert_valid_uuid_v4(value, message = nil)
    assert_match UUID_V4_REGEX, value, message || "Expected '#{value}' to be a valid UUID v4"
  end

  # Asserts that a value is a valid UUID (any version)
  # @param [String] value The UUID string to validate
  # @param [String] message Optional custom error message
  def assert_valid_uuid(value, message = nil)
    assert_match UUID_REGEX, value, message || "Expected '#{value}' to be a valid UUID"
  end
end
