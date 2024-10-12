require "rails_helper"

feature "User should be able to see goals" do
  scenario "it have a index page" do
    user = User.create(username: "riquelme", password: "123456")
    Goal.create(name: "goal1", user: user, private: true)
    Goal.create(name: "goal2", user: user, private: false)
    user_sign_in("riquelme", "123456")
    visit("/users/#{user.id}/goals")

    expect(page).to have_content("goal1")
    expect(page).to have_content("goal2")
  end
end

feature "User should be able to create goals" do
  scenario do
    user = User.create(username: "nicolas", password: "123456")
    visit("/users/#{user.id}/goals/new")
    fill_in "goal", with: "This is a goal"
    check "private"
    click_button "Create"

    expect(page).to have_content("This is a goal")
  end
end

feature "User should be able to delete goals" do
  user = User.create(username: "alberto", password: "123456")
  Goal.create(name: "goal3", user: user, private: false)
  visit("/users/#{user.id}/goals")
  click_on "delete"
  expect(page).not_to have_content("goal3")
end

feature "User should be able to update goals" do
  user = User.create(username: "susana", password: "123456")
  goal = Goal.create(name: "goal4", user: user, private: false)
  visit("goals/#{goal.id}")
  fill_in "goal", with: "editedGoal4"
  click_on "edit"
  expect(page).to have_content("goal4")
end

feature "User should be not be able to see others users private goals" do
  user1 = User.create(username: "gimena", password: "123456")
  user2 = User.create(username: "melina", password: "123456")
  Goal.create(name: "goal5", private: true)
  user_sign_in("gimena", "123456")
  visit("/users/#{user2.id}/goals")
  expect(page).not_to have_content("goal5")
end