Then(/^I should see a textbox with name "(.+?)"$/) do |element_name|
	PageHelper.page_has_textbox(browser = @browser, selector = {name: element_name}).should == true
end

Then(/^I should see a textbox with id "(.+?)"$/) do |element_id|
	PageHelper.page_has_textbox(browser = @browser, selector = {id: element_id}).should == true
end

When(/^I search using "(.+)"$/) do |search_field|
	case 

	when search_field == "referenceId"
		on(SearchPage).search_with_reference_id(form_reference_id="1")

	when search_field == "requestDate"
		on(SearchPage).search_with_request_date(form_request_date=Time.now.strftime("%d-%m-%Y"))

	when search_field == "vtsNumber"
		on(SearchPage).search_with_vts_number(form_vts_number= Vtsmovement.find(1).vts_number)
	end
end

Then(/^I should get search result with (\d+) row$/) do |num_rows|
	on(SearchResultsPage).search_result_summary.should == "#{num_rows} Record(s) found"
end

When(/^I click the details for row number (\d+)$/) do |row_number|
	@acknowledgement_reference_id = on(SearchResultsPage).show_details_for(row={:row_number => row_number})
end

#
# --- search with a user value
#
And(/^I search with "(.+)" set to "(.+?)"$/) do |search_field,value|
	case 

	when search_field == "referenceId"
		on(SearchPage).search_with_reference_id(form_reference_id = value)

	when search_field == "requestDate"
		on(SearchPage).search_with_request_date(form_request_date=value)

	when search_field == "vtsNumber"
		on(SearchPage).search_with_vts_number(form_vts_number = value)
	end
end

When(/^I search using "(.*?)" of the newly created request$/) do |search_field|
  case 

	when search_field == "referenceId"
		on(SearchPage).search_with_reference_id(form_reference_id = @acknowledgement_reference_id)

	when search_field == "requestDate"
		#TBD
	when search_field == "vtsNumber"
		#TBD
	end
end

#
# Verify that the search details are correctly displayed for the recent Vt14 request
#
And(/^the search details should have correct data displayed$/) do
	vt14_data = Vtsmovement.find(@acknowledgement_reference_id.to_i)
	# User_id is not displayed
	required_data = Hash[vt14_data.attributes.each.reject {|x,y| x == "user_id"}]

	required_data.values.each do |value|

		formatted_value=value

		case 

		when value.kind_of?(String)
			formatted_value = value

		when value.kind_of?(Date)
			formatted_value = "#{value.day}-#{value.mon}-#{value.year}"

		when value.kind_of?(Fixnum)
			formatted_value = value

		when value.kind_of?(Time)
		    formatted_value = "#{value.day.to_s}-#{value.mon.to_s}-#{value.year.to_s} #{value.hour.to_s}:#{value.min.to_s}:#{value.sec.to_s}"

		when value.kind_of?(NilClass)
		 	formatted_value = nil
		end

		if formatted_value
			@browser.text.include?(formatted_value.to_s).should == true 
		end
	end
end