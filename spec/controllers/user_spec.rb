require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "#new" do
    it "should render index template" do
      get "new"
      expect(response).to render_template("users/new")
    end
  end

  describe "#create" do
    it "should return 400 with invalid params" do
      post "create", params: {user: {password: "12345"}}
      expect(response).to have_http_status(302)
      have_current_path(new_user_path)
    end

    it "should return redirect with valid params" do
      post "create", params: { user: {username: "test10", password: "123456"} }
      expect(response).to have_http_status(302)
      have_current_path(homes_url)
    end
  end
end