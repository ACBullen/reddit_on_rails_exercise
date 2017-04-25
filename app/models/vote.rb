class Vote < ApplicationRecord
  validates_inclusion_of :value, in: [-1, 1]

  belongs_to :votable, polymorphic: true
end
