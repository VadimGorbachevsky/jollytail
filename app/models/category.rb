class Category < ApplicationRecord

  has_many :products
  has_ancestry

  validates :name, presence: true

  def to_param
    "#{id}-#{slug}"
  end


  private

  def set_slug
    self.slug = self.name.to_s.parameterize
  end
end
