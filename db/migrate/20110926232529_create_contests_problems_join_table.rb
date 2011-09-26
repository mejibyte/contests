class CreateContestsProblemsJoinTable < ActiveRecord::Migration
  def up
    remove_column :problems, :contest_id
    create_table :contests_problems, :id => false do |t|
      t.integer :contest_id
      t.integer :problem_id
    end
  end

  def down
    drop_table :contests_problems
    add_column :problems, :contest_id, :integer
  end
end
