require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @valid_user = users(:one)
  end

  # Validation Tests
  test "valid user with required attributes" do
    assert @valid_user.valid?
  end

  test "invalid without name" do
    @valid_user.name = nil
    refute @valid_user.valid?
    assert_includes @valid_user.errors[:name], "can't be blank"
  end

  test "invalid without biography" do
    @valid_user.biography = nil
    refute @valid_user.valid?
    assert_includes @valid_user.errors[:biography], "can't be blank"
  end

  # Random User Tests
  test "random_user returns nil when database is empty" do
    ensure_empty_database
    assert_nil User.random_user
  end

  test "random_user returns a valid user instance" do
    assert_instance_of User, User.random_user
  end

  test "random_user returns one of the existing users" do
    ensure_empty_database
    users = create_test_users

    random_user = User.random_user
    assert_includes users.map(&:id), random_user.id,
      "Random user should be one of the test users"
  end

  private

  def ensure_empty_database
    User.delete_all
  end

  def create_test_users
    [
      User.create!(name: "Test User 1", biography: "Bio 1"),
      User.create!(name: "Test User 2", biography: "Bio 2")
    ]
  end
end
