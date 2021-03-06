class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :sales_status
  belongs_to_active_hash :shipping_fee_status
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :scheduled_delivery

  belongs_to :user
  has_one :order, dependent: :destroy
  has_many_attached :images

  half_width_number = /\A[0-9]+\z/

  with_options presence: true do
    validates :images
    validates :name
    validates :info
    validates :price, format: { with: half_width_number, message: 'は半角数字で入力してください' },
                      numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                                      message: 'は¥300~¥9,999,999で設定してください' }
  end
  with_options numericality: { other_than: 1, message: 'を選択してください' } do
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end
end
