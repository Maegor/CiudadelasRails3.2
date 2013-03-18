class WaitingRoom < ActiveRecord::Base
  has_many :users

  attr_accessible :name, :user
end
