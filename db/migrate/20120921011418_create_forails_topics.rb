class CreateForailsTopics < ActiveRecord::Migration
  def change
    create_table :forails_topics do |t|
      t.string :name
      t.integer :forum_id
      t.integer :user_id

      t.timestamps
    end
  end
end
