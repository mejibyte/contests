class Team < ActiveRecord::Base
  belongs_to :contest
  validates_presence_of :username
end
