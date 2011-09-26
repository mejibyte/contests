class Problem < ActiveRecord::Base
  validates_presence_of :number, :judge_url
  validates_numericality_of :number
  belongs_to :contest
end
