class AddIsCategoryToForum < ActiveRecord::Migration
  def change
    change_table :forails_forums do |t|
      t.boolean :is_category, default: false
    end
  end
end
