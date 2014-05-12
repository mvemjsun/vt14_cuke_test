class Vtsmovement < ActiveRecord::Base

	validates :vts_reason, presence: true
	validates :vts_number, presence: true
	validates :vts_trading_name, presence: true
	validates :vts_address1, presence: true
	validates :vts_address2, presence: true
	validates :vts_postcode, presence: true
	validates :vts_telephone_number, presence: true
	validates :vts_mobile_number, presence: true
	validates :vts_site_contact, presence: true
	validates :vts_cli_telephone, presence: {if: "vts_reason != 'VTS Deinstall'", message: "Please provide a CLI telephone number."}
	validates :vts_complies, presence: {if: "vts_reason != 'VTS Deinstall'", message: "VTS must comply with testing  guide."}
	validates :vts_complies,
	   inclusion: { in: %w(Y),    message: "%{value} is not a valid value for - complies with testing guide.", allow_nil: true  }

	validates :ao_administrator, presence: true
	validates :ao_motcomp_user_id, presence: true,
		format: { with: /[a-zA-Z]{4}\d{4}/i,    message: "Userid format is not valid." }
	validates :ao_name, presence: true
	validates :ao_number, presence: true
	validates :ao_telephone_number, presence: true
	validates :ao_email, presence: true, 
	   format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,    message: "Email address is not valid." }

	belongs_to :user

	validates :vts_cessation_date, presence: {if: "vts_reason == 'VTS Deinstall'", message: "Please provide a valid cessation date"}
	validates :vts_alternate_address1, presence: {if: "vts_alternate_postcode.present?", message: "Address line 1 and 2 needed if postcode present"}
	validates :vts_alternate_address2, presence: {if: "vts_alternate_postcode.present?", message: "Address line 1 and 2 needed if postcode present"}	
	validates :vts_alternate_postcode, presence: {if: "vts_alternate_address1.present?", message: "Postcode is needed if address line entered"}
	validate :vts_cessation_date_cannot_be_in_the_past

	before_save :normalize_data

	DEFAULT_DATA = {
		:vts_reason => "VTS Deinstall",
		:vts_cessation_date => "2014-09-01",
		:vts_number => "V189776",
		:vts_trading_name => "Mikes Garage",
		:vts_address1 => "Bush House",
		:vts_address2 => "Topman Business Park",
		:vts_address3 => "William Road, Mansfield",
		:vts_postcode => "B13 9WW",
		:vts_telephone_number => "01211 123128",
		:vts_mobile_number => "04589476543",
		:vts_site_contact => "Andrew James",
		:vts_cli_telephone => "01273 491111",
		:vts_complies => "Y",
		:ao_administrator => "Desmond Wills",
		:ao_motcomp_user_id => "NORM0001",
		:ao_name => "Mitcham Area 13",
		:ao_number => "13",
		:ao_telephone_number => "020 8665 5715",
		:ao_email => "D.Wills@vosa.gsi.gov.uk"
	}	

	def vts_cessation_date_cannot_be_in_the_past
		if vts_cessation_date.present? && vts_cessation_date < Date.today
		  errors.add(:vts_cessation_date, "Cessation date cannot be in the past")
		end
	end

	def normalize_data
		norm_data = self.vts_number.upcase.gsub("\s","")
		self.vts_number = norm_data
		norm_data = self.ao_motcomp_user_id.upcase
		self.ao_motcomp_user_id = norm_data
		norm_data = self.vts_postcode.upcase
		self.vts_postcode = norm_data
	end

	def self.create_test_data(form_data={},rows=nil)

		rows = 10 if rows.nil?
		rows.times do |x|
			vtsmovement = Vtsmovement.new
			vtsmovement.vts_reason= PageHelper.randomize_data ['VTS Install', 'VTS Deinstall', 'VTS Movement']
			if vtsmovement.vts_reason == "VTS Deinstall"
				vtsmovement.vts_cessation_date = "31-12-2019"
			end
			vtsmovement.vts_number= PageHelper.randomize_data ['V100203', '78YLV','V123FD']
			vtsmovement.vts_trading_name= Faker::Company.name
			vtsmovement.vts_address1= PageHelper.randomize_data(1..999)
			vtsmovement.vts_address2= PageHelper.randomize_data ['Bird Lane','Jocks Lane','Bill drive','Rose street','Yellow Rd','Smith Ave']
			vtsmovement.vts_address3= Faker::Address.county

			vtsmovement.vts_postcode= PageHelper.randomize_data ['EC1A 1BB','W1A 1HQ','M1 1AA','B33 8TH','CR2 6XH','DN55 1PT']
			vtsmovement.vts_telephone_number= Faker::PhoneNumber.phone_number
			vtsmovement.vts_mobile_number= Faker::PhoneNumber.cell_phone
			vtsmovement.vts_site_contact= Faker::Name.name
			if vtsmovement.vts_reason != "VTS Deinstall"
				vtsmovement.vts_cli_telephone= Faker::PhoneNumber.phone_number
				vtsmovement.vts_complies = "Y"
			end
			vtsmovement.vts_alternate_address1= PageHelper.randomize_data(1..999)
			vtsmovement.vts_alternate_address2= "Address line 2"
			vtsmovement.vts_alternate_address3= Faker::Address.county
			vtsmovement.vts_alternate_postcode= PageHelper.randomize_data ['EC1A 1BB','W1A 1HQ','M1 1AA','B33 8TH','CR2 6XH','DN55 1PT']
			vtsmovement.ao_administrator= Faker::Name.name
			vtsmovement.ao_motcomp_user_id= PageHelper.randomize_data (['NORM0001', 'ADMI0001','TONK0001','HART0001'])
			vtsmovement.ao_name= PageHelper.randomize_data ['01SL2 -- VOSA Perth', '07SL1 -- VOSA Swynnerton','10SL5 -- VOSA Newport']
			vtsmovement.ao_number = PageHelper.randomize_data ['01SL2', '07SL1','10SL5']
			vtsmovement.ao_telephone_number= Faker::PhoneNumber.phone_number
			vtsmovement.ao_email= Faker::Internet.email("vosa")
			vtsmovement.user_id = 1

			# if form_data
			# 	form_data.each do |field,value|
			# 		eval "vtsmovement.#{field} = '#{value}'" if vtsmovement.respond_to? "#{field}="
			# 		eval "vtsmovement.check_#{field}" if vtsmovement.respond_to? "check_#{field}"
			# 	end
			# end
			vtsmovement.save

		end
	end

end