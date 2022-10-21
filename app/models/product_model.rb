class ProductModel < ApplicationRecord
  belongs_to :supplier
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :stock_products
  validates :name, :sku, :width, :height, :depth, :weight,  presence:true
  validates :width, :height, :depth, :weight, comparison: { greater_than: 0 }
  validates :sku, uniqueness: true
  validates :sku, length: { is: 20 }

end
