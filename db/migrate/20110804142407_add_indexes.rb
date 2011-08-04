class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :projects, :client_id
    add_index :events, :project_id
  end

  def self.down
    remove_index :projects, :client_id
    remove_index :events, :project_id
  end
end
