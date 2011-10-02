class Problem < ActiveRecord::Base
  validates_presence_of :number, :judge_url
  validates_numericality_of :number
  has_and_belongs_to_many :contests
  
  def belongs_to_at_least_one_running_contest?
    running_contests = Contest.running.all
    (self.contests & running_contests).size > 0
  end
end
