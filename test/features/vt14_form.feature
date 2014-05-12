@vt14
Feature: VT14 Form

Background:
Given I visit the VT14 LoginPage
And I try to login as a "normal" user

Scenario: VTS Reason for movement should be a select list with correct options
	Given When I select the VTS reason for movement then the following options should be presented
	| option_text         |
	| -- Please select -- |
	| VTS Install         |
	| VTS Deinstall       |
	| VTS Movement        |

Scenario: Selecting a VTS reason for movement to check state of cessation date
	When I select VTS reason for movement as "VTS Install"
	Then the text box for "vts_cessation_date" should be "disabled"
	When I select VTS reason for movement as "VTS Movement"
	Then the text box for "vts_cessation_date" should be "disabled"
	When I select VTS reason for movement as "VTS Deinstall"
	Then the text box for "vts_cessation_date" should be "enabled"

Scenario: selecting from the area office select list
	When I select an area office "11SL1 -- VOSA Poole" from the select list
	Then the area office number should be populated automatically with "11SL1"
	And the text box for "ao_number" should be "disabled"

Scenario: Complete the form and send email.
	Given I try to fill the VT14 form with random data
	Then I select VTS reason for movement as "VTS Install"
	And I set text box for "vts_cli_telephone" with "024 56565656"
	When I email the form
	Then I should see text "Your request for VTS movement has been processed"

Scenario: Create an install, deinstall and movement VT14 request
	Given I try to fill the VT14 form with random data
	Then I select VTS reason for movement as "VTS Install"
	And I set text box for "vts_cli_telephone" with "024 56565656"
	And I set text box for "vts_number" with "V987654321"
	When I email the form
	Then I should see text "Your request for VTS movement has been processed"
	Then I want to fill a new VT14

	Given I try to fill the VT14 form with random data
	Then I select VTS reason for movement as "VTS Deinstall"
	And I set text box for "vts_cessation_date" with "01-09-2016"
	And I set text box for "vts_number" with "V987654321"
	When I email the form
	Then I should see text "Your request for VTS movement has been processed"
	Then I want to fill a new VT14

	Given I try to fill the VT14 form with random data
	Then I select VTS reason for movement as "VTS Movement"
	And I set text box for "vts_cli_telephone" with "024 56565656"
	And I set text box for "vts_number" with "V987654321"
	When I email the form
	Then I should see text "Your request for VTS movement has been processed"
	And I logout

	Given I try to login as a "admin" user
	Then I click the link "Search" on "VT14Page"
	And I search with "vtsNumber" set to "V987654321"
	Then I should get search result with 3 row

Scenario: mandatory check for VTS number
	Given I try to fill the VT14 form with random data leaving out "vts_number"
	When I email the form
	Then I should see text "Please correct VTS number"

Scenario: mandatory check for VTS trading name
	Given I try to fill the VT14 form with random data leaving out "vts_trading_name"
	When I email the form
	Then I should see text "Please correct VTS trading name"

Scenario: mandatory check for VTS postcode
	Given I try to fill the VT14 form with random data leaving out "vts_postcode"
	When I email the form
	Then I should see text "Please correct VTS postcode"	

Scenario: mandatory check for VTS telephone number
	Given I try to fill the VT14 form with random data leaving out "vts_telephone_number"
	When I email the form
	Then I should see text "Please correct VTS telephone number"

Scenario: mandatory check for VTS mobile number
	Given I try to fill the VT14 form with random data leaving out "vts_mobile_number"
	When I email the form
	Then I should see text "Please correct VTS mobile number"

Scenario: mandatory check for VTS site contact
	Given I try to fill the VT14 form with random data leaving out "vts_site_contact"
	When I email the form
	Then I should see text "Please correct VTS site contact"	

Scenario: mandatory check for VTS address line 1
	Given I try to fill the VT14 form with random data leaving out "vts_address1"
	When I email the form
	Then I should see text "Please correct VTS address line 1"	

Scenario: mandatory check for Administrator name
	Given I try to fill the VT14 form with random data leaving out "ao_administrator"
	When I email the form
	Then I should see text "Please correct AO administrator name"

Scenario: mandatory check for Administrator user id
	Given I try to fill the VT14 form with random data leaving out "ao_motcomp_user_id"
	When I email the form
	Then I should see text "Please correct AO administrator userid"

Scenario: mandatory check for AO name
	Given I try to fill the VT14 form with random data 
	Then I unselect AO name
	When I email the form
	Then I should see text "Please select an AO name"	
	Then I should see text "AO number is not present"

Scenario: mandatory check for AO email
	Given I try to fill the VT14 form with random data leaving out "ao_email"
	When I email the form
	Then I should see text "Please correct AO email id"

Scenario: Entering an invalid cessation date
	Given I try to fill the VT14 form with random data 
	Then I select vts reason to be deinstall
	And I enter an invalid cessation date
	When I email the form
	Then I should see text "Date should be in future"

Scenario: Entering a past cessation date
	Given I try to fill the VT14 form with random data 
	Then I select vts reason to be deinstall
	And I enter an past cessation date
	When I email the form
	Then I should see text "Cessation date cannot be in the past"

Scenario: CLI needed for Movement and Install and not fo deinstalls
	Given I try to fill the VT14 form with random data
	When I select vts reason to be deinstall  
	Then the text box for "vts_cli_telephone" should be "disabled"
	When I select VTS reason for movement as "VTS Movement"
	Then the text box for "vts_cli_telephone" should be "enabled"
	When I select VTS reason for movement as "VTS Install"
	Then the text box for "vts_cli_telephone" should be "enabled"

Scenario: mandatory check for CLI
	Given I try to fill the VT14 form with random data 
	When I select VTS reason for movement as "VTS Install"
	And I set text box for "vts_cli_telephone" with ""
	When I email the form
	Then I should see text "Please provide a CLI telephone number"