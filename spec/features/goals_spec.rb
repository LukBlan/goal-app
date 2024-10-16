require "rails_helper"

feature "Read Goal: " do
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

feature "Create Goal: " do
  subject { User.create(username: "nicolas", password: "123456") }

  before :each do
    user_sign_in("nicolas", "123456")
  end

  scenario "it have a new goals page" do
    visit("/users/#{subject.id}/goals/new")
    expect(page).to have_content("New Goal")
  end

  scenario do
    visit("/users/#{subject.id}/goals/new")
    fill_in "name", with: "This is a goal"
    check "private"
    click_button "Create"

    expect(page).to have_content("This is a goal")
  end
end

feature "Delete Goal: " do
  scenario "User can see a delete button on goals screen" do
    reinaldo = User.create!(username: "reinaldo", password: "123456")
    Goal.create!(name: "goal3", user: reinaldo, private: false)
    user_sign_in("reinaldo", "123456")

    visit("/users/#{reinaldo.id}/goals")

    expect(page).to have_content("goal3")
    expect(page).to have_content("delete")
  end

  scenario "User delete a goal clicking delete button" do
    reinaldo = User.create!(username: "reinaldo", password: "123456")
    Goal.create!(name: "goal3", user: reinaldo, private: false)
    user_sign_in("reinaldo", "123456")

    visit("/users/#{reinaldo.id}/goals")
    click_on "delete"
    expect(page).to_not have_content("goal3")
  end

  scenario "User don't see delete button on other's user goals screen" do
    reinaldo = User.create!(username: "reinaldo", password: "123456")
    vincent = User.create!(username: "vincent", password: "123456")
    Goal.create!(name: "goal3", user: reinaldo, private: false)
    Goal.create!(name: "goal4", user: vincent, private: false)
    user_sign_in("reinaldo", "123456")

    visit("/users/#{vincent.id}/goals")
    expect(page).to have_content("goal4")
    expect(page).not_to have_content("delete")
  end
end

feature "Update Goals" do
  scenario "user click on edit button" do
    user = User.create(username: "susana", password: "123456")
    goal = Goal.create(name: "goal4", user: user, private: false)
    user_sign_in("susana", "123456")
    visit("goals/#{goal.id}")
    fill_in "goal", with: "editedGoal4"
    click_on "edit"
    expect(page).to have_content("goal4")
  end
end

feature "User should be not be able to see others users private goals" do
  scenario "user visit other user goals page" do
    user1 = User.create(username: "gimena", password: "123456")
    user2 = User.create(username: "melina", password: "123456")
    Goal.create(name: "goal5", private: true, user: user2)
    Goal.create(name: "goal6", private: false, user: user2)
    user_sign_in("gimena", "123456")
    visit("/users/#{user2.id}/goals")
    expect(page).not_to have_content("goal5")
    expect(page).to have_content("goal6")
  end
end