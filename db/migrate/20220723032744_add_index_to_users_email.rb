class AddIndexToUsersEmail < ActiveRecord::Migration[6.1]
  def change
    add_index :table, :user_id
  end
end
