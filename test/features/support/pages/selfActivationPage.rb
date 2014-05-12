require 'page-object'

class SelfActivationPage
	include PageObject

	text_field(:registration_userid, :name => "registration_userid")
	text_field(:registration_email_address, :name => "registration_email_address")
	select_list(:registration_email_domain, :id => "registration_email_domain_id")
	button(:get_activation_code, :name => "get_activation_code")

	# TODO, make DRY with DEFAULT_DATA ?
	
	def complete_details_for_new_user_correctly
		self.registration_userid = Pagedata.register_new_userid
		self.registration_email_address = Pagedata.register_new_userid_email_first_part
		self.registration_email_domain = "@atos.net"
		self.get_activation_code
	end

	def complete_details_for_existing_user_correctly
		self.registration_userid = Pagedata.normal_user_id
		self.registration_email_address = "normal"
		self.registration_email_domain = "@atos.net"
		self.get_activation_code
	end

	def complete_details_for_new_user_and_existing_email
		self.registration_userid = Pagedata.register_new_userid
		self.registration_email_address = "normal"
		self.registration_email_domain = "@atos.net"
		self.get_activation_code
	end

	def complete_details_for_existing_user_with_wrong_email
		self.registration_userid = Pagedata.normal_user_id
		self.registration_email_address = "normal.name"
		self.registration_email_domain = "@atos.net"
		self.get_activation_code
	end	

end