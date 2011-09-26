class Contest < ActiveRecord::Base
  attr_accessible :name, :start_date, :end_date
  validates :name, :start_date, :end_date, :presence => true
  validate :start_date_must_be_before_end_date
  
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
  
  protected
  
  def start_date_must_be_before_end_date
    if start_date.present? and end_date.present?
      errors.add(:start_date, "must be before end date") unless start_date < end_date
    end
  end
end
