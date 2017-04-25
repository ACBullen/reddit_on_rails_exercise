class Comment < ApplicationRecord
  validates :content, :author, :post, presence: true

  def score
    self.votes.sum(:value)
  end

  def comments_by_parent_id
    comment_hash = Hash.new { [] }
    self.child_comments.includes(:author).each do |comment|
      comment_hash[comment.parent_comment_id] += [comment]
    end
    comment_hash
  end

  belongs_to :author,
             primary_key: :id,
             foreign_key: :user_id,
             class_name: :User

  belongs_to :post

  belongs_to :parent_comment,
             primary_key: :id,
             foreign_key: :parent_comment_id,
             class_name: :Comment,
             optional: true

  has_many :child_comments,
           primary_key: :id,
           foreign_key: :parent_comment_id,
           class_name: :Comment

  has_many :votes, as: :votable
end
