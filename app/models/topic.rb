class Topic < ApplicationRecord
  has_many :posts, :sponsoredposts, dependent: :destroy
end
