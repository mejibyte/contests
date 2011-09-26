class Contest < ActiveRecord::Base
  attr_accessible :name, :start_date, :end_date
  validates :name, :start_date, :end_date, :presence => true
  validate :start_date_must_be_before_end_date
  
  protected
  
  def start_date_must_be_before_end_date
    if start_date.present? and end_date.present?
      errors.add(:start_date, "must be before end date") unless start_date < end_date
    end
  end
end
