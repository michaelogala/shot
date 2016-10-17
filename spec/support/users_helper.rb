def sign_up
  visit root_path
  click_link 'Sign Up'
  fill_signup_form
end

def sign_in
  visit root_path
  click_link 'Sign In'
  user = create(:user)
  fill_in 'session_email', with: user.email
  fill_in 'session_password', with: user.password
  click_button 'Log in'
end

def create_a_link(link)
  fill_in 'link_given_url', with: link.given_url
  fill_in 'link_slug', with: link.slug
  click_button 'CREATE LINK'
end

def fill_signup_form
  user = build(:user)

  fill_in 'user_first_name', with: user.first_name
  fill_in 'user_last_name', with: user.last_name
  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: user.password
  fill_in 'user_password_confirmation', with: user.password
  click_button 'Sign up'
end
