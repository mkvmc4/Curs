class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  attribute :quantity, :integer, default: 1
end
