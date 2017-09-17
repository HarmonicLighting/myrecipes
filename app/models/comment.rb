class Comment < ApplicationRecord

  validates :description, presence: true, length: { in: 4..140 }
  belongs_to :chef
  belongs_to :recipe
  default_scope -> { order(updated_at: :desc)}
end
