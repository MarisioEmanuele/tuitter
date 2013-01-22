class AddCategoryToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :category_id, :integer
  end
end
