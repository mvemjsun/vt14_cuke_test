require 'debugger'

class User < ActiveRecord::Base
  
  #attr_accessor :old_password, :new_password	
  attr_accessor :password,:password_confirmation

  validates :userid,   presence: true, uniqueness: true
  validates :password, presence: true,:confirmation => true, length: { minimum: 7 , message: "must be at least 7 characters long."}
  validates :userid, length: { is: 8 , message: "must be 8 characters long."}
  validates :userid, format: { with: /[a-zA-Z]{4}[0-9]{4}/,    message: "format should be XXXX9999, where XXXX are alphabets and 9999 are digits." }
  validate :user_full_name, presence: true
  validates :user_email_address, presence: true, 
     format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,    message: "Email address is not valid." }
  validates :user_email_address, uniqueness: { case_sensitive: false , message: "Email address has already been taken."}

  has_many :vtsmovements

  before_save :encrypt_password

  def self.authenticate(login, pass)
    u = User.find_by_userid(login.downcase)
    return nil if u.nil?
    return u if u.has_password?(pass) 
    nil     
  end

  def has_password?(pass)
    hashed_password == encrypt(pass,self.salt)
  end

  def is_admin?
    self.admin == true ? true : false
  end

  def logged_in_user
    return self.userid.upcase
  end

  def self.create_test_admin_user
    admin_user = User.new
    admin_user.userid = "admi0001"
    admin_user.password = "password"
    admin_user.admin = true
    admin_user.user_full_name = "Mr Administrator"
    admin_user.user_email_address = "Administrator@atos.net"
    admin_user.save
  end

  def self.create_test_normal_user
    normal_user = User.new
    normal_user.userid = "norm0001"
    normal_user.password = "password"
    normal_user.admin = false
    normal_user.user_full_name = "Mr Normal"
    normal_user.user_email_address = "Normal@atos.net"
    normal_user.save
  end

  def self.change_password(userid,old_password,new_password)
    u = self.authenticate(userid,old_password)
    return nil if u.nil?
    u.password = new_password
    u.save
  end

  def self.reset_password(supplied_userid,supplied_password,new_password,entered_code)
    rc = Registrationcode.user_exists?(supplied_userid.downcase)

    if rc
      code = Registrationcode.find_by_registration_userid(supplied_userid.downcase)
      if (code.expires_at >= Time.now && code.activation_code == entered_code) 
        u = User.find_by_userid(supplied_userid.downcase)
        return nil if u.nil?
        u.password = supplied_password
        u.password_confirmation = new_password
        u.save
        code.expire
        code.save
      else
        nil
      end
    end
  end


  private

  def encrypt_password
    self.salt = random_salt(10) 
    self.hashed_password = encrypt(password, salt)
    self.userid = self.userid.downcase
    self.user_email_address = self.user_email_address.downcase
  end

  def encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass + salt)
  end

  def random_salt(len)
    chars = ("a".."z").to_a + ("0".."9").to_a + ("A".."Z").to_a 
    str = ""
    1.upto(len) { |i| str << chars[rand(chars.size-1)] }
    return str
  end

end