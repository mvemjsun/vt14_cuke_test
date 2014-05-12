When(/^I insert data into the user table$/) do 
  us = User.new
  us.userid='admi0001'
  us.password='password'
  us.admin=false
  us.user_full_name="Mr Full Name"
  us.user_email_address="email@example.com"
  us.save
end

Then(/^the the user should be able to authenticate himself with correct password$/) do 
  User.authenticate('ADMI0001','password').should == User.first
end

Then(/^the user should fail authentication is the password is invalid$/) do 
  User.authenticate('ADMI0001','secret').should == nil
end

Then(/^the user should fail authentication is the userid is invalid$/) do 
  User.authenticate('ADMI0002','password').should == nil
end

When(/^I insert data into the user table without password$/) do 
  @us_no_pass = User.new
  @us_no_pass.userid='ADMI0001'
  @us_no_pass.password=nil
  @us_no_pass.admin=false
  @us_no_pass.user_full_name="Mr Full Name"
  @us_no_pass.user_email_address="email@example.com"
  @us_no_pass.save
end

Then(/^I should get an error password "(.*?)"$/) do |message|
  @us_no_pass.errors.messages[:password].should == [message]
end

When(/^I insert data into the vtsmovements table$/) do
	@vts = Vtsmovement.new(Vtsmovement::DEFAULT_DATA)
end

Then(/^the data should be save successfully in the vtsmovements table$/) do
	Vtsmovement.count.should == 1
end

When(/^I supply no vts_reason$/) do
  @vts.vts_reason = nil
end

When(/^I supply invalid vts_complies$/) do
  @vts.vts_complies = 'YES'
end

When(/^I supply invalid ao_email$/) do
  @vts.ao_email = 'email_at_example.com'
end

When(/^I try to save the data into vtsmovements table$/) do
  @vts.save
end

Then(/^I should get an error "(.*?)" "(.*?)"$/) do |column,message|
  @vts.errors.messages[column.to_sym].should == [message]
end

When(/^I insert data into the registrationcode table$/) do 
  rc = Registrationcode.new
  rc.registration_userid = 'ADMI0001'
  rc.save
end

Then(/^the data should be save successfully in the registrationcode table$/) do
  Registrationcode.count.should == 1
end
