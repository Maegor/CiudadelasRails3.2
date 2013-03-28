class WaitingRoom < ActiveRecord::Base
  has_many :users
  validates :name, :presence => true, :uniqueness => true
  validates :user, :presence => true

  attr_accessible :name, :user
end
