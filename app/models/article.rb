class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_rich_text :context

  validates :title, presence: true, uniqueness: true, length: { maximum: 255 }

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end
