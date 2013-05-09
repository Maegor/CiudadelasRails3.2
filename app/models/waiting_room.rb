class WaitingRoom < ActiveRecord::Base
  has_many :users

  validates :name,
            :presence => true,
            :uniqueness => true,
            :length => {:within => 3..12}
  validates :user,
            :presence => true,
            :inclusion => {:in => [2,3,4,5,6,7,8]}

  attr_accessible :name, :user,:visible





end
