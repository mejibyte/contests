class CreateProblems < ActiveRecord::Migration
  def self.up
    create_table :problems do |t|
      t.integer :number
      t.string :judge_url
      t.integer :contest_id
      t.timestamps
    end
  end

  def self.down
    drop_table :problems
  end
end
