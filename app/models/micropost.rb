class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  MICRO_ATTR = %i(content image).freeze

  validates :content, presence: true,
                      length: {maximum: Settings.micropost.content_max}
  validates :image, content_type: {in: Settings.micropost.image_type_in,
                                   message: :image_type_err},
                                   size: {
                                     less_than: Settings.image_size.megabytes,
                                     message: :image_size_err
                                   }
  delegate :name, to: :user, prefix: true
  scope :newest, ->{order created_at: :desc}

  def display_image
    image.variant(resize_to_limit: Settings.micropost.resize_image)
  end
end
