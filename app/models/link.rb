class Link < ApplicationRecord
  validates :url, presence: true

  scope :recent_first, -> { order(created_at: :desc) }
end
