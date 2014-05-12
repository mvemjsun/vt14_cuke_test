@db
Feature: Validating the VT14 database schema. The schema has the following tables in it.
         Users & vtsmovements. 
@create_user
Scenario: Inserting data into the Users table with data.
	When I insert data into the user table 
	Then the the user should be able to authenticate himself with correct password
	And the user should fail authentication is the password is invalid
	And the user should fail authentication is the userid is invalid

Scenario: Inserting data into the Users table withot password.
	When I insert data into the user table without password
	Then I should get an error password "can't be blank"

Scenario: Adding data into the vts movements table.
	Given I insert data into the vtsmovements table
	When I try to save the data into vtsmovements table
	Then the data should be save successfully in the vtsmovements table

Scenario: Adding data into vts movements table with vts_reason data missing.
	When I insert data into the vtsmovements table
	And I supply no vts_reason
	When I try to save the data into vtsmovements table
	Then I should get an error "vts_reason" "can't be blank"

Scenario: Adding data into vts movements table with vts_complies data invalid.
	When I insert data into the vtsmovements table
	And I supply invalid vts_complies
	When I try to save the data into vtsmovements table
	Then I should get an error "vts_complies" "YES is not a valid value for - complies with testing guide."

Scenario: Adding data into vts movements table with ao_email data invalid.
	When I insert data into the vtsmovements table
	And I supply invalid ao_email
	When I try to save the data into vtsmovements table
	Then I should get an error "ao_email" "Email address is not valid."
@rc
Scenario: Generate an activation code for a user.
	When I insert data into the registrationcode table
	Then the data should be save successfully in the registrationcode table