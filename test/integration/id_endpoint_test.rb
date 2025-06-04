require "test_helper"

class IdEndpointTest < ActionDispatch::IntegrationTest
  test "should return a valid UUID" do
    get "/id"
    assert_response :success

    # Verify response is a valid UUID
    uuid = JSON.parse(@response.body)["id"]
    assert uuid.present?
    assert_match(/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/, uuid)
  end

  test "should respond within 50ms" do
    start_time = Time.now
    get "/id"
    end_time = Time.now

    assert_response :success
    response_time = (end_time - start_time) * 1000 # Convert to milliseconds
    assert response_time < 50, "Response time #{response_time.round(2)}ms exceeded 50ms limit"
  end
end
