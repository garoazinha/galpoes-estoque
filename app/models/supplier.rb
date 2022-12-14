class Supplier < ApplicationRecord
  has_many :product_models
  validates :corp_name, :brand_name, :registration_id, :email, presence: true
  validates :registration_id, uniqueness: true
  validates :registration_id, format: { with: /\A[0-9]{14}\z/ , message: 'deve possuir 14 dígitos'}

  def full_description
    ("#{corp_name} -
    CNPJ: #{CNPJ.new(registration_id).formatted}")
  end

end
