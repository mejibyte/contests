class Contest < ActiveRecord::Base
  has_and_belongs_to_many :teams
  has_many :problems, :dependent => :destroy
  has_many :submissions, :dependent => :destroy
  
  validates :name, :start_date, :end_date, :presence => true
  validate :start_date_must_be_before_end_date
  
  accepts_nested_attributes_for :problems, :reject_if => proc { |attr| attr["number"].blank? and attr["judge_url"].blank? }, :allow_destroy => :true
  
  def teams_attributes=(attributes)
    attributes.reject! do |index, team_attributes|
      team_attributes["username"].blank? or ActiveRecord::ConnectionAdapters::Column.value_to_boolean(team_attributes.delete("_destroy"))
    end
    self.teams = []
    self.teams = attributes.collect do |index, team_attributes|
      Team.where(:username => team_attributes["username"]).first || Team.new(team_attributes)
    end
  end
  
  def duration # in minutes
    (end_date - start_date) / 60
  end
  
  def time_left
    (end_date - Time.now) / 60
  end
  
  def running?
    start_date <= Time.now and Time.now <= end_date
  end
  
  def finished?
    Time.now > end_date
  end

  def time_to_start
    (start_date - Time.now) / 60
  end
  
  def teams_sorted_by_score
    teams.all.sort_by { |team| [number_of_solved_problems(team), -total_penalty(team)] }.reverse
  end
  
  def number_of_solved_problems(team)
    submissions.where(:team_id => team, :verdict => "Accepted").collect(&:problem_id).uniq.size
  end
  
  def first_accepted_submission(team, problem)
    submissions.where(:team_id => team, :verdict => "Accepted", :problem_id => problem).order("submitted_at ASC").first    
  end
  
  def time_of_first_solution(team, problem)
    submission = first_accepted_submission(team, problem)
    submission.blank? ? nil : ((submission.submitted_at - start_date) / 60).round
  end
  
  def problem_solved?(team, problem)
    first_accepted_submission(team, problem).present?
  end
  
  def wrong_tries_before_solution(team, problem)
    solution = first_accepted_submission(team, problem)
    date = solution.blank? ? end_date + 1 : solution.submitted_at
    submissions.where(:team_id => team, :problem_id => problem).where("verdict != 'Accepted'").where("submitted_at < ?", date).count
  end
  
  def penalty_for_single_problem(team, problem)
    if problem_solved?(team, problem)
      time_of_first_solution(team, problem) + wrong_tries_before_solution(team, problem) * 20
    else
      0
    end
  end
  
  def total_penalty(team)
    problems.inject(0) { |sum, problem| sum + penalty_for_single_problem(team, problem) }
  end
  
  def letter_for_problem(problem)
    problems.each_with_index do |p, i|
      return ('A'.ord + i).chr if p == problem
    end
    return '~'
  end
  
  def within_contest_time_lapse?(some_time)
    start_date <= some_time and some_time <= end_date
  end
  
  protected
  
  def start_date_must_be_before_end_date
    if start_date.present? and end_date.present?
      errors.add(:start_date, "must be before end date") unless start_date < end_date
    end
  end
end
