class Link < ApplicationRecord
  belongs_to :user, optional: true
  has_many :views, dependent: :destroy
  validates :url, presence: true

  scope :recent_first, -> { order(created_at: :desc) }

  after_save_commit if: :url_previously_changed? do
    MetadataJob.perform_later(to_param)
  end

  def self.find(id)
    super(ShortCode.decode(id))
  end

  def to_param
    ShortCode.encode(id)
  end

  def domain
    URI(url).host rescue URI::InvalidError
  end

  def editable_by?(user)
    return false unless user_id?
    user_id == user&.id
  end
end
