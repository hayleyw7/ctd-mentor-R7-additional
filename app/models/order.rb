class Order < ApplicationRecord
  belongs_to :customer

  validates :product_name, presence: true
  validates :product_count, numericality: { greater_than_or_equal_to: 1 }
end
