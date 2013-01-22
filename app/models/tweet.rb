class Tweet < ActiveRecord::Base
  attr_accessible :text, :user_id, :category_id
  validates :text, :presence => true
  validates :category_id, :presence => true
  belongs_to :category
  belongs_to :user
end
