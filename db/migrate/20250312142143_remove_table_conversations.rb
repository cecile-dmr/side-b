class RemoveTableConversations < ActiveRecord::Migration[7.1]
  def change
    drop_table :conversations
  end
end
