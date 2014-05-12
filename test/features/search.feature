@vt14 @search
Feature: As a VT14 portal user I must be able to search the VT14 data using a date or VTS number or reference ID

Background:
Given I visit the VT14 LoginPage
And I try to login as a "admin" user

Scenario: Login using admin user to access search
	Then I should see a link to "Search" on VT14Page
	And the page title should be "VT14 admin"

Scenario: Access the search link
	When I click the link "Search" on "SearchPage"
	Then I should see a textbox with name "vts_number"
	And I should see a textbox with name "request_date"
	And I should see a textbox with name "reference_id"
	And I should see a textbox with id "vts_number_id"
	And I should see a textbox with id "request_date_id"

Scenario: Search using reference id
	Given I click the link "Search" on "VT14Page"
	When I search using "referenceId"
	Then I should get search result with 1 row
	When I click the details for row number 1
	Then I should see text "VT14 details"

Scenario: Search using request date
	Given I click the link "Search" on "VT14Page"
	When I search using "requestDate"
	Then I should get search result with 10 row
	When I click the details for row number 5
	Then I should see text "VT14 details"
	And the search details should have correct data displayed

Scenario: Create a new VT14 and then search for it
	Given I click the link "New VT14" on "VT14Page"
	Then I try to fill the VT14 form with random data
	And I email the form
	When I click the link "Search" on "VT14Page"
	And I search using "referenceId" of the newly created request
	Then I should get search result with 1 row
	When I click the details for row number 1
	Then I should see text "VT14 details"
	And the search details should have correct data displayed