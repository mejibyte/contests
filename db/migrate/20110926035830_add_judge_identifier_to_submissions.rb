class AddJudgeIdentifierToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :judge_identifier, :string
  end
end
