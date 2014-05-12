Then(/^I try to fill the VT14 form with random data$/) do
	on(VT14Page).fill_vt14_form
end

Given(/^When I select the VTS reason for movement then the following options should be presented$/) do |select_options|
	presented_reasons = on(VT14Page).reasons_for_movement
	expected_reasons=[]
	expected_reasons_raw = select_options.rows
	expected_reasons_raw.each {|reason| expected_reasons << reason[0]}
	(presented_reasons == expected_reasons).should == true
end

When(/^I select VTS reason for movement as "(.*?)"$/) do |reason_to_be_selected|
	on(VT14Page).vts_reason = reason_to_be_selected
end

Then(/^the text box for "(.*?)" should be "(.*?)"$/) do |text_box,state|
	case 
	when state == "enabled"
		on(VT14Page) do |page|
			lambda { page.send("#{text_box}=","2014-01-01")}.should_not raise_error(Watir::Exception::ObjectReadOnlyException)
		end
	when state == "disabled"
		on(VT14Page) do |page|
			lambda { page.send("#{text_box}=","2014-01-01")}.should raise_error(Watir::Exception::ObjectReadOnlyException)
		end
	end
end

When(/^I select an area office "(.*?)" from the select list$/) do |ao_name|
	on(VT14Page) do |page|
		page.ao_select_name = ao_name
	end
end

Then(/^the area office number should be populated automatically with "(.*?)"$/) do |ao_number|
	on(VT14Page) do |page|
		page.ao_number.should == ao_number
	end
end

When(/^I email the form$/) do
	on(VT14Page).send_email
	@acknowledgement_reference_id = on(AcknowledgementPage).acknowledgement_reference_id if @browser.text.include?("Reference :")
end

Then(/^I should see text "(.*?)"$/) do |text|
	@browser.text.include?(text).should == true
end

Then(/^I try to fill the VT14 form with random data leaving out "(.*?)"$/) do |missing_field|
	on(VT14Page).fill_vt14_form(form_data = {missing_field => ""})
end

Then(/^I unselect AO name$/) do
	on(VT14Page).ao_select_name = "-- Please select --"
end

Then(/^I select vts reason to be deinstall$/) do
	on(VT14Page).vts_reason = "VTS Deinstall"
end

And(/^I enter an invalid cessation date$/) do
	on(VT14Page).vts_cessation_date = '2014-99-99'
end

And(/^I enter an past cessation date$/) do
	on(VT14Page).vts_cessation_date = '01-01-2014'
end

When(/^I set text box for "(.*?)" with "(.*?)"$/) do |form_field, field_value|
	on(VT14Page) do |page|
		if page.respond_to? form_field
			page.send("#{form_field}=", field_value)  
		end
	end
end