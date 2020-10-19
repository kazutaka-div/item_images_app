class Item < ApplicationRecord
  has_many :likes
  has_many :images, dependent: :destroy
  belongs_to :user
  ## reject_ifは、trueなら排除するという意味。
  accepts_nested_attributes_for :images, allow_destroy: true, update_only: true, reject_if: :no_image

  ## image_attributesは引数なので、名前はなんでも良い。blank?で空だったら、trueを返す。
  def no_image(image_attributes)
    image_attributes[:src].blank?
  end

  ## この記述がなくても、保存はできる。が、これがないと、ビューとかで呼び出して表示させることができない。
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  def like_by?(user)
    likes.where(user_id: user.id).exists?
  end

  validates :name, presence: true
  validates :price, presence: true
  validates :prefecture_id, presence: true

end
