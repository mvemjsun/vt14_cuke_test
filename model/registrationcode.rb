class Registrationcode < ActiveRecord::Base

	  validates :registration_userid, presence: true, uniqueness: true
	  validates :registration_userid, length: { is: 8 , message: "must be 8 characters long."}
    validates :registration_userid, format: { with: /[a-zA-Z]{4}[0-9]{4}/,    message: "format should be XXXX9999, where XXXX are alphabets and 9999 are digits." }

  	before_save :generate_activation_code

  	def self.user_exists?(userid)
  		rc = Registrationcode.find_by_registration_userid(userid)
  		return true if rc != nil
  		false
  	end

  	def generate_activation_code
  		self.registration_userid = self.registration_userid.downcase
  		# self.expires_at = DateTime.now + 60.minutes 
      # self.activation_code = random_string(6)
  	end

	def random_string(len)
	   chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
	   str = ""
	   1.upto(len) { |i| str << chars[rand(chars.size-1)] }
	   return str
	end  	

  def expire
    self.expires_at = DateTime.now
  end

end