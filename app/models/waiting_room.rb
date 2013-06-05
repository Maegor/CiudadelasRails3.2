class WaitingRoom < ActiveRecord::Base
  has_many :users

  validates :name,
            :presence => true,
            :uniqueness => true
  validates :name,
            :length => {:in => 3..12}, :unless => Proc.new{|a| a.name.blank?}

  validates :user,
            :inclusion => {:in => [2,3,4,5,6,7,8]}

  attr_accessible :name, :user ,:visible





end
