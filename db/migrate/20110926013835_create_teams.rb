class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :username
      t.string :judge_identifier
      t.integer :contest_id
      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
