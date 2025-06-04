require "test_helper"

class UserEndpointTest < ActionDispatch::IntegrationTest
  test "should return user details with correct format" do
    get "/user"
    assert_response :success

    response_body = JSON.parse(@response.body)

    # Check response structure
    assert_includes response_body.keys, "id"
    assert_includes response_body.keys, "name"
    assert_includes response_body.keys, "biography"

    # Validate UUID format (PostgreSQL format)
    assert_match(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/, response_body["id"])

    # Validate data types
    assert_kind_of String, response_body["name"]
    assert_kind_of String, response_body["biography"]
  end

  test "should respond within 300ms" do
    start_time = Time.now
    get "/user"
    end_time = Time.now

    assert_response :success
    response_time = (end_time - start_time) * 1000 # Convert to milliseconds

    # We'll test for slightly under 300ms to give some margin for CI environments
    assert response_time < 300, "Response time #{response_time.round(2)}ms exceeded 300ms limit"
  end

  test "should return non-empty values" do
    get "/user"
    assert_response :success

    response_body = JSON.parse(@response.body)

    # Ensure values are present and non-empty
    assert_not_empty response_body["id"]
    assert_not_empty response_body["name"]
    assert_not_empty response_body["biography"]
  end
end
