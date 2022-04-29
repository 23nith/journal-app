class Category < ApplicationRecord
  validates :title, presence: true, length: { maximum: 18 }, uniqueness: true
end
