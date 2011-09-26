class Contest < ActiveRecord::Base
  has_many :teams, :dependent => :destroy
  has_many :problems, :dependent => :destroy
  
  validates :name, :start_date, :end_date, :presence => true
  validate :start_date_must_be_before_end_date
  
  accepts_nested_attributes_for :teams, :reject_if => proc { |attr| attr["username"].blank? }, :allow_destroy => :true
  accepts_nested_attributes_for :problems, :reject_if => proc { |attr| attr["number"].blank? and attr["judge_url"].blank? }, :allow_destroy => :true
  
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
    teams.all.sort_by { |team| [1, 1] }
  end
  
  protected
  
  def start_date_must_be_before_end_date
    if start_date.present? and end_date.present?
      errors.add(:start_date, "must be before end date") unless start_date < end_date
    end
  end
end
