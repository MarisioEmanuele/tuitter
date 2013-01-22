class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.integer :followed_user_id
      t.integer :follower_user_id

      t.timestamps
    end
    
    add_index :followings, [:follower_user_id, :followed_user_id], :unique => true
    add_index :followings, :follower_user_id
    add_index :followings, :followed_user_id
  end
end