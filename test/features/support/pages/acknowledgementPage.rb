require 'page-object'
class AcknowledgementPage

	include PageObject

	h4(:acknowledgement_message, :id => "ack_message")

	# Ack Message has format <lot of text>.Reference : <reference_number>
	def acknowledgement_reference_id
		acknowledgement_message.split(":")[1].gsub(/\s/,"")
	end

end