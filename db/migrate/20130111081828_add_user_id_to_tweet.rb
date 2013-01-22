class AddUserIdToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :user_id, :integer, :null => false, :default => -1
  end
end