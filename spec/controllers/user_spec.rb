require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "new" do
    it "should render index template" do
      get "/users/new"
      expect(response).to render_template("people/index")
    end
  end

  describe "create" do
    it "should return 400 with invalid params" do
      post "/users", params: {password: "12345"}
      expect(response).to have_http_status(400)
    end

    it "should return redirect with valid params" do
      post "/users", params: {username: "test10", password: "12345"}
      expect(response).to have_http_status(300)
    end
  end
end