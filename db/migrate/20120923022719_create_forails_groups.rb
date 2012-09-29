class CreateForailsGroups < ActiveRecord::Migration
  def change
    create_table :forails_groups do |t|
      t.string :name

      t.timestamps
    end
    
    create_table :forails_groups_users, primary_key: false do |t|
      t.integer :user_id
      t.integer :group_id
    end
  end
end
