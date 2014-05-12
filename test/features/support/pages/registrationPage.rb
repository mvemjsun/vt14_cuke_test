require 'page-object'
class RegistrationPage

	include PageObject

	text_field(:userid, :name => "userid")
	text_field(:user_full_name, :name => "user_full_name")
	text_field(:user_email_address, :name => "user_email_address")
	text_field(:password, :name => "password")
	text_field(:password_confirmation, :name => "password_confirmation")
	text_field(:user_activation_code, :name => "activation_code")
	button(:register, :name => "register")

	def register_new_user
		self.userid = Pagedata.register_new_userid
		self.user_full_name = "Mr Newly Registered User"
		self.user_email_address = "new.registration@atos.net"
		self.password = "password"
		self.password_confirmation = "password"
		data_row = Registrationcode.select("activation_code").where(registration_userid: Pagedata.register_new_userid.downcase)
		self.user_activation_code = data_row.first.activation_code
		self.register
	end
end