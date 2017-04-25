class Sub < ApplicationRecord
  validates :moderator, :title, :description, presence: true
  include FriendlyId

  friendly_id :title

  belongs_to  :moderator,
              primary_key: :id,
              foreign_key: :mod_id,
              class_name: :User
  has_many :postings

  has_many :posts,
           through: :postings,
           source: :post,
           inverse_of: :subs
end
