require 'page-object'

class VT14Page

	include PageObject
	include DataMagic

	link(:logout, :text=> "Logout")
	link(:generate_activation_code, :text=> "Generate Activation Code")
	link(:change_password, :text => "Change Password")
	link(:new_vt_14, :text => "New VT14")
	link(:home, :text => "Home")

	select_list(:vts_reason, :id => "vts_reason_id")
	text_field(:vts_cessation_date, :id => "vts_cessation_date_id")

	text_field(:vts_number, :id => "vts_number_id")
	text_field(:vts_trading_name, :id => "vts_trading_name_id")
	text_field(:vts_address1, :id => "vts_address1_id")
	text_field(:vts_address2, :id => "vts_address2_id")
	text_field(:vts_address3, :id => "vts_address3_id")
	text_field(:vts_postcode, :id => "vts_postcode_id")
	text_field(:vts_telephone_number, :id => "vts_telephone_number_id")
	text_field(:vts_mobile_number, :id => "vts_mobile_number_id")
	text_field(:vts_site_contact, :id => "vts_site_contact_id")
	text_field(:vts_cli_telephone, :id => "vts_cli_telephone_id")
	checkbox(:vts_complies, :id => "vts_complies_id")

	text_field(:vts_alternate_address1, :id => "vts_alternate_address1_id")
	text_field(:vts_alternate_address2, :id => "vts_alternate_address2_id")
	text_field(:vts_alternate_address3, :id => "vts_alternate_address3_id")
	text_field(:vts_alternate_postcode, :id => "vts_alternate_postcode_id")

	text_field(:ao_administrator, :id => "ao_administrator_id")
	text_field(:ao_motcomp_user_id, :id => "ao_motcomp_user_id")
	select_list(:ao_select_name, :id => "ao_select_name_id")
	text_field(:ao_number, :id => "ao_number_id")
	text_field(:ao_telephone_number, :id => "ao_telephone_number_id")
	text_field(:ao_email, :id => "ao_email_id")

	button(:send_email, :value => "Send VT14 to VOSA service desk")

	def has_link?(link_text)
		txt = @browser.link(:text => link_text).text
		link_text.should == txt
	end

	def fill_vt14_form(form_data={})
		
		self.vts_reason= PageHelper.randomize_data ['VTS Install', 'VTS Deinstall', 'VTS Movement']
		if self.vts_reason == "VTS Deinstall"
			self.vts_cessation_date = "31-12-2019"
		end
		self.vts_number= PageHelper.randomize_data ['V100203', '78YLV','V123FD']
		self.vts_trading_name= Faker::Company.name
		self.vts_address1= PageHelper.randomize_data(1..999)
		self.vts_address2= Faker::Lorem.words(1)
		self.vts_address3= Faker::Address.county
		# self.vts_postcode= Faker::Address.zip
		self.vts_postcode= PageHelper.randomize_data ['EC1A 1BB','W1A 1HQ','M1 1AA','B33 8TH','CR2 6XH','DN55 1PT']
		self.vts_telephone_number= Faker::PhoneNumber.phone_number
		self.vts_mobile_number= Faker::PhoneNumber.cell_phone
		self.vts_site_contact= Faker::Name.name
		if self.vts_reason != "VTS Deinstall"
			self.vts_cli_telephone= Faker::PhoneNumber.phone_number
		end
		#self.check_vts_complies ## automatically done
		self.vts_alternate_address1= PageHelper.randomize_data(1..999)
		self.vts_alternate_address2= Faker::Lorem.words(1)
		self.vts_alternate_address3= Faker::Address.county
		self.vts_alternate_postcode= PageHelper.randomize_data ['EC1A 1BB','W1A 1HQ','M1 1AA','B33 8TH','CR2 6XH','DN55 1PT']
		self.ao_administrator= Faker::Name.name
		self.ao_motcomp_user_id= PageHelper.randomize_data (['NORM0001', 'ADMI0001','TONK0001','HART0001'])
		self.ao_select_name= PageHelper.randomize_data ['01SL2 -- VOSA Perth', '07SL1 -- VOSA Swynnerton','10SL5 -- VOSA Newport']
		self.ao_telephone_number= Faker::PhoneNumber.phone_number
		self.ao_email= Faker::Internet.email("vosa")	

		if form_data
			form_data.each do |field,value|
				eval "self.#{field} = '#{value}'" if self.respond_to? "#{field}="
				eval "self.check_#{field}" if self.respond_to? "check_#{field}"
			end
		end
	end

	def reasons_for_movement
		opt=[]
		vts_reason_element.options.each {|x| opt << x.text}
		opt
	end
	
end