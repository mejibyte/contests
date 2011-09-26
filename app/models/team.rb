class Team < ActiveRecord::Base
  validate :username, :presence => true, :unique => true
  has_and_belongs_to_many :contests
end
