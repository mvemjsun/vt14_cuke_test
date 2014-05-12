@self_activation
Feature: A new user can request a self activation code in case he needs to register at the VT14 site. The code generated will be emailed to the user at the email address provided by him. The email address allowed will be only for the vosa or atos domains.

Background: 
	Given I visit the VT14 LoginPage

Scenario: Visiting the website to access self activation service.
	Then I should see a link to "Activation service" on LoginPage
	When I click the link "Activation service" on "LoginPage"
	Then I should see text "Receive activation code"
	And the page title should be "VT14 self activation request"
	And I should see a textbox with name "registration_userid"
	And I should see a textbox with name "registration_email_address"

Scenario: Generate an activation code for a new user and register successfully
	Then I click the link "Activation service" on "LoginPage"
	And I complete details to get an activation code for a new user
	Then I should see text "Your activation code has been emailed to you"
	When I click the link "Not Registered" on "ActivationServiceAcknowledgementPage"
	And I register my details with using the emailed activation code
	Then I should see text "User registered successfully"

Scenario: Generate an activation code for an existing user and change password
	Then I click the link "Activation service" on "LoginPage"
	And I complete details to get an activation code for an existing user
	Then I should see text "Your activation code has been emailed to you"
	When I click the link "Reset password" on "ActivationServiceAcknowledgementPage"
	And I complete details to change the password using the emailed activation code
	Then I should see text "Password reset with success"

Scenario: Generate an activation code for an exiting user and provide wrong email address
	Then I click the link "Activation service" on "LoginPage"
	When I complete details to get an activation code for an existing user with wrong email address
	Then I should see text "User ID and email address does not match our records"
@wip
Scenario: Generate an activation code for a new user and provide existing email address
	Then I click the link "Activation service" on "LoginPage"
	When I complete details to get an activation code for an new user with existing email address
	Then I should see text "Email address is already registered against a different User ID"