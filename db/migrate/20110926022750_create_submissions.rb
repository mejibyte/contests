class CreateSubmissions < ActiveRecord::Migration
  def self.up
    create_table :submissions do |t|
      t.string :verdict
      t.string :language
      t.string :run_time
      t.datetime :submitted_at
      t.integer :team_id
      t.integer :contest_id
      t.integer :problem_id
      t.timestamps
    end
  end

  def self.down
    drop_table :submissions
  end
end
