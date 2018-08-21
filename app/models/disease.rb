class Disease < ApplicationRecord
  extend FriendlyId
  include PgSearch
  friendly_id :disease_slug, use: :slugged
  belongs_to :category, class_name: Major.name, foreign_key: :category_id

  pg_search_scope :search,
    against: [:name, :content_html],
    using: {
      tsearch: {
        prefix: true
      }
    }

  scope :name_asc, ->{order "name ASC"}
  scope :exclude_content, ->{select "id, name, slug"}

  def disease_slug
    "#{name}##{id}"
  end
end
