require "rails_helper"

feature "Read Goal: " do
  scenario "User can see goals" do
    user = User.create(username: "riquelme", password: "123456")
    Goal.create(name: "goal1", user: user, private: true)
    Goal.create(name: "goal2", user: user, private: false)
    user_sign_in("riquelme", "123456")
    visit("/users/#{user.id}/goals")

    expect(page).to have_content("goal1")
    expect(page).to have_content("goal2")
  end

  scenario "User should not be able to see others users private goals" do
    User.create(username: "gimena", password: "123456")
    melina = User.create(username: "melina", password: "123456")
    Goal.create(name: "goal5", private: true, user: melina)
    Goal.create(name: "goal6", private: false, user: melina)

    user_sign_in("gimena", "123456")
    visit("/users/#{melina.id}/goals")

    expect(page).not_to have_content("goal5")
    expect(page).to have_content("goal6")
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

  scenario "User can create new goal" do
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

feature "Update Goals:" do
  scenario "Goal have a edit button" do
    user = User.create(username: "susana", password: "123456")
    goal = Goal.create(name: "goal4", user: user, private: false)

    user_sign_in("susana", "123456")
    visit("users/#{user.id}/goals")

    expect(page).to have_content("edit")
  end

  scenario "There is a edit page" do
    user = User.create(username: "susana", password: "123456")
    Goal.create(name: "goal4", user: user, private: false)

    user_sign_in("susana", "123456")
    visit(user_goals_url(user))

    click_link "edit"

    expect(page).to have_content("Edit your goal")
  end

  scenario "User can edit goal" do
    user = User.create(username: "susana", password: "123456")
    goal = Goal.create(name: "goal4", user: user, private: false)

    user_sign_in("susana", "123456")
    visit(edit_goal_url(goal))
    fill_in "Goal Name", with: "goal4444"
    click_button "Edit"
    expect(page).to have_content("goal4444")
  end
end