require 'page-object'
class PasswordResetPage

	include PageObject

	page_url 'http://localhost:4567/reset_password'
	text_field(:userid, :name => "userid")
	text_field(:password, :name => "password")
	text_field(:new_password, :name => "new_password")
	text_field(:reset_code, :name => "reset_code")
	button(:reset_password, :name => "reset_password")

	def reset_password_with_activationcode
		self.userid = Pagedata.normal_user_id
		self.password = "password"
		self.new_password = "password"
		data_row = Registrationcode.select("activation_code").where(registration_userid: Pagedata.normal_user_id.downcase)
		self.reset_code = data_row.first.activation_code
		reset_password
	end
end