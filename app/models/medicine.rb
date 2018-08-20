class Medicine < ApplicationRecord
  extend FriendlyId
  include PgSearch
  belongs_to :medicine_type

  friendly_id :medicine_slug, use: :slugged
  pg_search_scope :search,
    against: [:name, :overview],
    using: {
      tsearch: {
        prefix: true
      }
    }

  def medicine_slug
    "#{name} #{id}"
  end

  def same_type limit = Settings.default.limit
    Medicine.where("medicine_type_id = ? and id not in (?)",
      medicine_type_id, id).limit limit
  end
end
