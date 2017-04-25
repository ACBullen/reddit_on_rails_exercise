class Posting < ApplicationRecord
  validates :sub, :post, presence: true

  belongs_to :post, inverse_of: :postings
  belongs_to :sub, inverse_of: :postings
end
