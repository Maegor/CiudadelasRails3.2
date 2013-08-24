require 'digest/sha2'
class User < ActiveRecord::Base


has_many :players
has_many :parties, :through => :players
belongs_to :waiting_room




attr_accessible :name, :email, :password, :password_confirmation, :lang

validates :email, :presence => true, :uniqueness => { :case_sensitive => false }
validates :name,
          :presence => true,
          :uniqueness => { :case_sensitive => false }
validates :name,
          :length => {:in => 3..10}, :unless => Proc.new{|a| a.name.blank?}
validates :password,
          :presence => true,
          :on => :create
validates  :password,
           :confirmation => true

validates :password,
          :length => {:in => 6..20}, :unless => Proc.new{|a| a.password.blank?}

validates :email,
          :format => {:with => /^.+@.+$/}, :unless => Proc.new{|a| a.email.blank?}

attr_accessor :password_confirmation
attr_reader :password

#validate :password_must_be_present

def player

  players.find_by_current('TRUE')

end



class << self
  def authenticate(email, password)
    if (user = find(:first, :conditions => ['lower(email) = ?',email.downcase]))
      if user.hashed_password == encrypt_password(password, user.salt)
        user
      end
    end
  end

  def encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + 'wibble' + salt)
  end

end


def password=(pwd)
  
  @password = pwd  
  if password.present?
    generate_salt
   self.hashed_password = self.class.encrypt_password(password, salt)   
  end  
end

private
def password_must_be_present
  errors.add(:password, 'Missing password') unless hashed_password.present?
  
end

def generate_salt
  self.salt = self.object_id.to_s + rand.to_s
end



  
end
