require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)  # Assuming we have a fixture
  end

  test "should be valid with name and biography" do
    assert @user.valid?
  end

  test "should require name" do
    @user.name = nil
    refute @user.valid?
    assert_includes @user.errors[:name], "can't be blank"
  end

  test "should require biography" do
    @user.biography = nil
    refute @user.valid?
    assert_includes @user.errors[:biography], "can't be blank"
  end

  test "random_user should return a user when users exist" do
    assert_not_nil User.random_user
    assert_instance_of User, User.random_user
  end

  test "random_user should return nil when no users exist" do
    User.delete_all
    assert_nil User.random_user
  end

  test "random_user should return one of the existing users" do
    User.delete_all # Start with a clean slate

    # Create two users
    user1 = User.create!(name: "User 1", biography: "Bio 1")
    user2 = User.create!(name: "User 2", biography: "Bio 2")

    # Get a random user and verify it's one of our created users
    random_user_id = User.random_user.id
    assert_includes [ user1.id, user2.id ], random_user_id,
      "Random user ID should be one of the created user IDs"
  end
end
