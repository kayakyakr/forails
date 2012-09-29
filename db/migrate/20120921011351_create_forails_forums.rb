class CreateForailsForums < ActiveRecord::Migration
  def change
    create_table :forails_forums do |t|
      t.string :name
      t.integer :parent_forum_id
      t.integer :sequence
      t.string :description

      t.timestamps
    end
  end
end
