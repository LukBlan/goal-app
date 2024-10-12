require 'rails_helper'

feature "Sign Up" do
  scenario "has a new user page" do
    visit("/users/new")
    expect(page).to have_content("Sign Up")
  end

  scenario "shows username on homepage after signup" do
    user_sign_up("user_sign_up_test1", "123456")
    expect(page).to have_content("user_sign_up_test1")
  end

  scenario "show to short password error message if Sign Up password is to short" do
    user_sign_up("user_sign_up_test2", "1234")
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Password is to short")
  end

  scenario "show missing username message if username is missing on Sign Up" do
    user_sign_up(nil, "123456")
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Username is missing")
  end

  scenario "show missing password message if username is missing on Sign Up" do
    user_sign_up("test4", nil)
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Password is to short")
  end
end

feature "Log In" do

end

feature "Log Out" do

end