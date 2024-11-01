require 'rails_helper'

feature "User Comments:" do
  scenario "User should be able to navigate to user profile" do
    User.create!(username: "Example", password: "123456")
    random_user = User.create!(username: "RandomUser", password: "123456")
    user_sign_in("Example", "123456")
    visit("/users/#{random_user.id}")
    expect(page).to have_content("RandomUser")
  end

  scenario "User should be able to see an 'Add Comment' button" do
    User.create!(username: "TestAddCommentButton1", password: "123456")
    user = User.create!(username: "TestAddCommentButton2", password: "123456")
    user_sign_in("TestAddCommentButton1", "123456")
    visit("/users/#{user.id}")
    expect(page).to have_content("Add Comment")
  end

  scenario "User should be able to create a new comment" do
    User.create!(username: "TestCreateComment1", password: "123456")
    user = User.create!(username: "TestCreateComment2", password: "123456")
    user_sign_in("TestCreateComment2", "123456")
    visit("/users/#{user.id}")
    fill_in "comment", with: "RandomComment"
    click_button "Add Comment"

    expect(page).to have_content("RandomComment")
  end
end

feature "Goal Comments:" do
  scenario "User should be able to navigate others users goals profile" do
    User.create!(username: "GoalCommentProfile1", password: "123456")
    user = User.create!(username: "GoalCommentProfile2", password: "123456")
    goal = Goal.create!(user: user, name: "GoalComment")
    user_sign_in("GoalCommentProfile1", "123456")
    visit("/goals/#{goal.id}/comments")
  end

  scenario "User should be able to see an 'Add Comment' button" do

  end

  scenario "User should be able to create new comment" do

  end
end