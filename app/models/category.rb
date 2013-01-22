class Category < ActiveRecord::Base
  attr_accessible :name
  validates_uniqueness_of :name
  has_many :tweets
  
  def to_s
    "#{name}"
  end 
end
