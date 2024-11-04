class Article < ApplicationRecord
  belongs_to :user
  has_rich_text :context

  validates :title, presence: true, uniqueness: true, length: { maximum: 255 }
end
