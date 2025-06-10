require "test_helper"

class UserSerializerTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(
      name: "Test User",
      biography: "A test biography for serializer testing"
    )
  end

  test "serialize returns correct hash structure" do
    result = UserSerializer.serialize(@user)

    assert_instance_of Hash, result
    assert_equal 5, result.keys.length

    # Check all required keys are present
    assert_includes result.keys, :id
    assert_includes result.keys, :name
    assert_includes result.keys, :biography
    assert_includes result.keys, :created_at
    assert_includes result.keys, :updated_at
  end

  test "serialize returns correct values" do
    result = UserSerializer.serialize(@user)

    assert_equal @user.id, result[:id]
    assert_equal @user.name, result[:name]
    assert_equal @user.biography, result[:biography]
  end

  test "serialize returns timestamps as ISO8601 strings" do
    result = UserSerializer.serialize(@user)

    # Check that timestamps are strings
    assert_instance_of String, result[:created_at]
    assert_instance_of String, result[:updated_at]

    # Check ISO8601 format (YYYY-MM-DDTHH:MM:SSZ or YYYY-MM-DDTHH:MM:SS.sssZ)
    iso8601_regex = /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(Z|\.\d{3}Z)$/
    assert_match iso8601_regex, result[:created_at]
    assert_match iso8601_regex, result[:updated_at]
  end

  test "serialize handles all string types correctly" do
    result = UserSerializer.serialize(@user)

    # ID should remain as string (UUID)
    assert_instance_of String, result[:id]
    assert_valid_uuid(result[:id])

    # Name and biography should remain as strings
    assert_instance_of String, result[:name]
    assert_instance_of String, result[:biography]
  end

  test "serialize is consistent with multiple calls" do
    result1 = UserSerializer.serialize(@user)
    result2 = UserSerializer.serialize(@user)

    assert_equal result1, result2
  end

  test "serialize handles edge cases" do
    user_with_long_text = User.create!(
      name: "User with very long name " * 10,
      biography: "Very long biography text " * 100
    )

    result = UserSerializer.serialize(user_with_long_text)

    assert_instance_of Hash, result
    assert_equal user_with_long_text.name, result[:name]
    assert_equal user_with_long_text.biography, result[:biography]
  end
end
