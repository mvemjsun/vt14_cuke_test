When(/^I visit the VT14 LoginPage$/) do
  on(LoginPage) do |page|
    page.goto
  end
end

Then(/^I should get the login form$/) do
  on(LoginPage) do |page|
    page.userid_element.visible?.should == true
    page.password_element.visible?.should == true
    page.signin_element.visible?.should == true
  end
end

Then(/^I should see a link to "(.*?)" on (.*?)$/) do |link_text,page_name|
  on(page_name) do |page|
    page.has_link?(link_text).should == true
  end
end

When(/^I try to login with incorrect details$/) do
  on(LoginPage) do |page|
    page.login_unsuccessfully
  end
end

Then(/^I should see notice "(.*?)"$/) do |notice_text|
 @browser.text.include? notice_text
end

Then(/^the page title should be "(.*?)"$/) do |page_title|
  @browser.title.should == page_title
end

When(/^I try to login as a "(.*?)" user$/) do |user_type|
  on (LoginPage) do |page|
    case user_type
    when "normal"
      page.login_as(Pagedata.normal_user_id)

    when "admin"
      page.login_as(Pagedata.admin_user_id)
    end
  end
end

Then(/^I want to fill a new VT14$/) do
  on(VT14Page).new_vt_14
end

Then(/^I should be shown the VT14 form$/) do
   @browser.text.include? "VT14 Form"
end

When(/^I try to visit the VT14 ActivationCodePage without logging in$/) do
  @browser.goto Pagedata.activation_page_url
end

When(/^I click the link "(.*?)" on "(.*?)"$/) do |link_text,page_name|
  PageHelper.click_link_with_text(@browser,link_text)
end

Then(/^I should be shown the ActivationCodePage$/) do
  @browser.text.include? "Generate User activation code"
end

Then(/^I generate activation code for a new user$/) do
  PageHelper.click_link_with_text(@browser,"Generate Activation Code")
  on(ActivationCodePage) do |page|
    page.userid = Pagedata.activation_user_id
    page.generate_code
    @activation_code = page.generated_activation_code
  end
end

Then(/^I generate activation code for an existing user$/) do
  PageHelper.click_link_with_text(@browser,"Generate Activation Code")
  on(ActivationCodePage) do |page|
    page.userid = Pagedata.normal_user_id
    page.generate_code
    @activation_code = page.generated_activation_code
  end
end

Then(/^the new user should be able to register using the activation code$/) do
    @browser.link(:text =>'Logout').click if @browser.link(:text =>'Logout').exists?
    @browser.link(:text =>'Not Registered').wait_until_present
    @browser.link(:text =>'Not Registered').click
    on(RegistrationPage) do |page|
      page.userid =  Pagedata.activation_user_id
      page.user_full_name = Pagedata.activation_user_full_name
      page.user_email_address = Pagedata.activation_user_email_address
      page.password = Pagedata.correct_user_password
      page.password_confirmation = Pagedata.correct_user_password
      page.user_activation_code = @activation_code
      page.register
    end
    @browser.text.include? "User registered successfully"
end

Then(/^the new user should be able to reset his password using the activation code$/) do
  @browser.link(:text =>'Logout').click if @browser.link(:text =>'Logout').exists?
  @browser.link(:text =>'Reset password').wait_until_present
  @browser.link(:text =>'Reset password').click
  on(PasswordResetPage) do |page|
    page.userid =  Pagedata.normal_user_id
    page.password = Pagedata.correct_user_password
    page.new_password = Pagedata.correct_user_password
    page.reset_code = @activation_code
    page.reset_password
  end
  @browser.text.include? "Password reset with success"  
end

And(/^I logout$/) do
  on(VT14Page).logout
end