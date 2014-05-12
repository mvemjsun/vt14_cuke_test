require 'page-object'
class SearchPage

	include PageObject

	text_field(:vts_number, :id => "vts_number_id")
	text_field(:request_date, :id => "request_date_id")
	text_field(:reference_id, :id => "reference_id_id")
	button(:search, :name => "search")

	def has_link?(link_text)
		txt = @browser.link(:text => link_text).text
		link_text.should == txt
	end

	def search_with_vts_number(form_vts_number)
		if form_vts_number
			self.vts_number = form_vts_number
			search
		end
	end

	def search_with_request_date(form_request_date)
		if form_request_date
			self.request_date = form_request_date
			search
		end
	end

	def search_with_reference_id(form_reference_id)
		if form_reference_id
			self.reference_id = form_reference_id
			search
		end
	end

end