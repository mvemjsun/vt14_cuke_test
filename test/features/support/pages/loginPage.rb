require 'page-object'
class LoginPage

	include PageObject

	page_url 'http://localhost:4567/login'
	text_field(:userid, :name => "userid")
	text_field(:password, :name => "password")
	button(:signin, :name => "signin")
	link(:home_link, :text=> "Home")
	link(:register_link, :text=> "Not Registered")

	def has_link?(link_text)
		txt = @browser.link(:text => link_text).text
		link_text.should == txt
	end

	def login_unsuccessfully
		self.userid = Pagedata.normal_user_id
		self.password = Pagedata.incorrect_user_password
		signin
	end

	def login_successfully
		self.userid = Pagedata.normal_user_id
		self.password = Pagedata.correct_user_password
		signin
	end

	def login_as(login_user)
		self.userid = login_user
		self.password = Pagedata.correct_user_password
		signin
	end

end