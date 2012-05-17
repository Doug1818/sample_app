include ApplicationHelper

def sign_in user
	visit sign_in path
	fill_in "Email",    with: user.email
	fill_in "Password", with: user.password
	click_button "Sign in"
	# Sign in when not using Capybara as well
	cookies[:remeber_token] = user.remeber_token
end
