class Message < ApplicationRecord
  belongs_to :chef
  validates :content, presence: true
  validates :chef_id, presence: true

  def self.most_recent amount = 20
    order(:created_at).last(amount)
  end
end
