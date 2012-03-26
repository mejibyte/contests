class Team < ActiveRecord::Base
  has_and_belongs_to_many :contests
  has_many :submissions, :dependent => :destroy
  
  validates :username, :presence => true, :uniqueness => true
end
