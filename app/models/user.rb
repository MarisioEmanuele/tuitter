require 'digest/sha2'

class User < ActiveRecord::Base
  before_save :encrypt_password
  
  attr_accessor :password
  
  attr_accessible :email, :username, :password, :password_confirmation
  validates :username, :presence => true, :length => { :minimum => 3 }
  validates :email, :format => /@/
  validates :password, :presence => true, :confirmation => true, :on => "create"

  # Una associazione semplice
  has_many :tweets

  # Una associazione complessa.  Il modello "following" implementa una
  # relazione molti-a-molti fra User e User.
  has_many :followings_that_i_follow, 
    :foreign_key => "follower_user_id", 
    :class_name => "Following"
  has_many :users_that_i_follow, 
    :class_name => "User", 
    :through => :followings_that_i_follow,
    :source => :followed_user
  
  def not_following?(other_user)
    other_user != self && !following?(other_user)
  end

  def following?(other_user)
    self.users_that_i_follow.include?(other_user)
  end
  
  def start_following(other_user)
    case other_user
    when User
      followings_that_i_follow.create! :followed_user_id => other_user.id
    else
      followings_that_i_follow.create! :followed_user_id => other_user
    end
  end

  def authenticate(password)
    encrypt(password + self.password_salt) == self.password_digest
  end

  def encrypt_password
    if self.password
      self.password_salt = rand(256).to_s(16)
      self.password_digest = encrypt(password + password_salt)
    end
  end
  
  def encrypt(password)
    Digest::SHA2.hexdigest(password)
  end
  
  def to_s
    "@#{username}"
  end
end
