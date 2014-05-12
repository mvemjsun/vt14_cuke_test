FactoryGirl.define do
	factory :user do
		id 1
		userid 'ADMIN0001'
		password 's3cr3t'
		admin true
	end
end