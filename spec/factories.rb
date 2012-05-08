FactoryGirl.define do
	factory :user do
		name "John Doe"
		email "john.doe@example.com"
		password "foobar"
		password_confirmation "foobar"
	end
end