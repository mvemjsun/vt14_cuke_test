And(/^I complete details to get an activation code for a new user$/) do
	on(SelfActivationPage).complete_details_for_new_user_correctly
end

And(/^I complete details to get an activation code for an existing user$/) do
	on(SelfActivationPage).complete_details_for_existing_user_correctly
end

And(/^I register my details with using the emailed activation code$/) do
	on(RegistrationPage).register_new_user
end

And(/^I complete details to change the password using the emailed activation code$/) do
	on(PasswordResetPage).reset_password_with_activationcode
end

When(/^I complete details to get an activation code for an existing user with wrong email address$/) do
	on(SelfActivationPage).complete_details_for_existing_user_with_wrong_email
end

When(/^I complete details to get an activation code for an new user with existing email address$/) do
	on(SelfActivationPage).complete_details_for_new_user_and_existing_email
end