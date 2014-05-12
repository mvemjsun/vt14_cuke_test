require 'page-object'
class ChangepasswordPage

	include PageObject

	page_url 'http://localhost:4567/changepassword'
	text_field(:userid, :name => "userid")
	text_field(:password, :name => "password")
	text_field(:confirm_password, :name => "confirm_password")
	button(:change_password, :name => "change_password")
end