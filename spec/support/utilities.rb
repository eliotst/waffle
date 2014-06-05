def log_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    auth_token = User.new_auth_token
    cookies[:auth_token] = auth_token
    user.update_attribute(:auth_token, User.digest(auth_token))
  else
    visit log_in_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end
end