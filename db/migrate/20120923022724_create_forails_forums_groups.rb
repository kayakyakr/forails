class CreateForailsForumsGroups < ActiveRecord::Migration
  def change
    create_table :forails_forums_groups do |t|
      t.integer :forum_id
      t.integer :group_id
      t.string :permission

      t.timestamps
    end
  end
end
