class Disease < ApplicationRecord
  extend FriendlyId
  friendly_id :disease_slug, use: :slugged
  belongs_to :category, class_name: Major.name, foreign_key: :category_id

  scope :name_asc, ->{order "name ASC"}
  scope :exclude_content, ->{select "id, name, slug"}

  def disease_slug
    "#{name}##{id}"
  end
end
