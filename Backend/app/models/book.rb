class Book < ApplicationRecord
  validates :title, :description, :gender, presence: true
end