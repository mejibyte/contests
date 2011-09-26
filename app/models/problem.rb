class Problem < ActiveRecord::Base
  validates_presence_of :number, :judge_url
  validates_numericality_of :number
  has_and_belongs_to_many :contests
end
