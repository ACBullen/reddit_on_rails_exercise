class Post < ApplicationRecord
  validates :title, :postings, :author, presence: true
  extend FriendlyId
  friendly_id :title
  def comments_by_parent_id
    comment_hash = Hash.new { [] }
    self.comments.includes(:author).each do |comment|
      comment_hash[comment.parent_comment_id] += [comment]
    end
    comment_hash
  end

  def score
    self.votes.sum(:value)
  end


  belongs_to :author,
             primary_key: :id,
             foreign_key: :author_id,
             class_name: :User

  has_many :postings, inverse_of: :post

  has_many :comments, inverse_of: :post

  has_many :subs,
           through: :postings,
           source: :sub

  has_many :votes, as: :votable
end
