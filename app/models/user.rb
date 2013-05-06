require 'digest/sha2'
class User < ActiveRecord::Base


has_many :players
has_many :parties, :through => :players
belongs_to :waiting_room




attr_accessible :name, :email, :password, :password_confirmation, :lang
validates :email, :presence => true, :uniqueness => true
validates :name,
          :presence => true,
          :uniqueness =>  true,
          :length => {:in => 3..12}
validates :password,
          :confirmation => true,
          :presence => true,
          :length => {:in => 6..12}

validates :email, :format => {:with => /^.+@.+$/}
attr_accessor :password_confirmation
attr_reader :password

#validate :password_must_be_present

def player

  players.find_by_current('TRUE')

end



class << self
  def authenticate(email, password)
    if (user = find_by_email(email))
      if user.hashed_password == encrypt_password(password, user.salt)
        user
      end
    end
  end

  def encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "wibble" + salt)
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
  errors.add(:password, "Missing password") unless hashed_password.present?
  
end

def generate_salt
  self.salt = self.object_id.to_s + rand.to_s
end



  
end
