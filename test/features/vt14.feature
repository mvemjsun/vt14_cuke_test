@vt14
Feature: VT14 application submittion portal. VOSA users should be able to visit a website so that they can
         register and/or login and then submit details of a new VT14 for a vts movement.

Scenario: Visiting the website to check login page.
	When I visit the VT14 LoginPage
	Then I should get the login form
	And I should see a link to "Not Registered" on LoginPage
	And I should see a link to "Home" on LoginPage

Scenario: Visiting
	When I visit the VT14 LoginPage
	And I try to login with incorrect details
	Then I should see notice "Login failed - Try again"
	And I should see a link to "Not Registered" on LoginPage
	And I should see a link to "Home" on LoginPage
	And the page title should be "VT14 login"

Scenario: Visit the website and try to login as a normal user.
	When I visit the VT14 LoginPage
	And I try to login as a "normal" user
	Then I should be shown the VT14 form
	And I should see a link to "Logout" on VT14Page
	And I should see a link to "Home" on VT14Page
	And I should see a link to "Change Password" on VT14Page
	And the page title should be "VT14 form"

Scenario: Visit the website and try to login as a admin user.
	When I visit the VT14 LoginPage
	And I try to login as a "admin" user
	Then I should be shown the VT14 form
	And I should see a link to "Logout" on VT14Page
	And I should see a link to "Home" on VT14Page
	And I should see a link to "Change Password" on VT14Page
	And I should see a link to "Generate Activation Code" on VT14Page
	And the page title should be "VT14 admin"

Scenario: Try to access the activation code page without login.
	When I try to visit the VT14 ActivationCodePage without logging in
	Then I should get the login form

Scenario: Try to access the activation code page with admin login.
	When I visit the VT14 LoginPage
	And I try to login as a "admin" user
	Then I should see a link to "Generate Activation Code" on VT14Page
	When I click the link "Generate Activation Code" on "VT14Page"
	Then I should be shown the ActivationCodePage
	And the page title should be "VT14 user activation code"

Scenario: Generate and use an activation code for a user.
	Given I visit the VT14 LoginPage
	Then I try to login as a "admin" user
	And I click the link "Generate Activation Code" on "VT14Page"
	When I generate activation code for a new user
	Then the new user should be able to register using the activation code

Scenario: Password reset.
	Given I visit the VT14 LoginPage
	Then I try to login as a "admin" user
	And I click the link "Generate Activation Code" on "VT14Page"
	When I generate activation code for an existing user
	Then the new user should be able to reset his password using the activation code