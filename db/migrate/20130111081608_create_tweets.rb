class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :text

      t.timestamps
    end
  end
end
