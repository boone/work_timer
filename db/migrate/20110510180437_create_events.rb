class CreateEvents < ActiveRecord::Migration[4.2]
  def self.up
    create_table :events do |t|
      t.datetime :start
      t.datetime :end
      t.string :comment
      t.references :project
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
