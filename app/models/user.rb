class User < ApplicationRecord
  # Validations
  validates :name, presence: true
  validates :biography, presence: true

  # Returns a random user from the database
  # @return [User, nil] Returns a random user or nil if no users exist
  def self.random_user
    order("RANDOM()").first
  end
end
