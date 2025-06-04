class User < ApplicationRecord
  # Validations
  validates :name, presence: true
  validates :biography, presence: true
end
