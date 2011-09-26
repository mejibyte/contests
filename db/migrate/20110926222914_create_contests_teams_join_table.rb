class CreateContestsTeamsJoinTable < ActiveRecord::Migration
  def up
    remove_column :teams, :contest_id
    
    create_table :contests_teams, :id => false do |t|
      t.integer :contest_id
      t.integer :team_id
    end
    
  end

  def down
    drop_table :contests_teams
    
    add_column :teams, :contest_id, :integer
  end
end
