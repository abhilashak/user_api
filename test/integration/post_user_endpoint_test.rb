require "test_helper"

class PostUserEndpointTest < ActionDispatch::IntegrationTest
  setup do
    @valid_user_params = {
      name: "Test User",
      biography: "A test biography for integration testing"
    }
  end

  test "should handle user creation attempt" do
    post "/user", params: @valid_user_params, as: :json

    if response.status == 200
      # Success case
      response_body = JSON.parse(@response.body)
      assert_includes response_body.keys, "id"
      assert_includes response_body.keys, "name"
      assert_includes response_body.keys, "biography"

      # Verify saved data
      assert_equal @valid_user_params[:name], response_body["name"]
      assert_equal @valid_user_params[:biography], response_body["biography"]

      # Verify UUID format
      assert_match(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/, response_body["id"])
    else
      # Random failure case
      assert_response :unprocessable_entity
      response_body = JSON.parse(@response.body)
      assert_equal "Failed to save user (random failure simulation)", response_body["error"]
    end
  end

  test "should handle invalid parameters" do
    invalid_params = { name: "", biography: "" }

    post "/user", params: invalid_params, as: :json
    assert_response :unprocessable_entity

    response_body = JSON.parse(@response.body)
    assert_includes response_body.keys, "errors"
    assert_includes response_body["errors"]["name"], "can't be blank"
    assert_includes response_body["errors"]["biography"], "can't be blank"
  end

  test "should handle missing parameters" do
    post "/user", params: {}, as: :json
    assert_response :unprocessable_entity

    response_body = JSON.parse(@response.body)
    assert_includes response_body.keys, "errors"
    assert_includes response_body["errors"]["name"], "can't be blank"
    assert_includes response_body["errors"]["biography"], "can't be blank"
  end
end
