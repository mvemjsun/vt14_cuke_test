require 'page-object'
class ActivationCodePage

	include PageObject

	text_field(:userid, :name => "userid")
	button(:generate_code, :name => "generate_code")
	span(:activation_code, :id => "activation_code")

	def generated_activation_code
		activation_code
	end

end