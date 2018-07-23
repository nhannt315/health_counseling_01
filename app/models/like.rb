class Like < ApplicationRecord
  belongs_to :target, polymorphic: true
end
