class Image < ApplicationRecord
  belongs_to :item

  mount_uploader :src , ImageUploader

  validates :src, presence: true
end
