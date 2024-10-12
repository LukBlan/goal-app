require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it "should have a username" do
      user = User.new(password: "123456")

      expect(user).not_to be_valid
    end

    it "should have unique username" do
      user1 = User.create(username: "test1", password: "123456")
      user2 = User.new(username: "test1", password: "123456")

      expect(user2).not_to be_valid
    end

    it "should generate a session_token" do
      user = User.create(username: "test3", password: "123456")

      expect(user.session_token).not_to be_nil
    end

    it "should generate a password_digest" do
      user = User.create(username: "test4", password: "123456")

      expect(user.password_digest).not_to be_nil
      expect(user.password_digest).not_to eq(user.password)
    end
  end

  describe "::find_by_session_token" do
    let(:user) { User.create(username: "test5", password: "123456") }

    it  "should get user session token" do
      found_user = User.find_by_session_token(user.session_token)
      expect(found_user.username).to eq(user.username)
    end
  end

  describe "::find_by_credentials" do
    let(:user) {User.create(username: "test6", password: "123456")}

    it "should find user by credentials" do
      found_user = User.find_by_credentials(user.username, "123456")
      expect(found_user.username).to eq(user.username)
    end

    it "should return nil if invalid credentials" do
      found_user = User.find_by_credentials(user.username, "1234")
      expect(found_user).to be_nil
    end

    it "should return nil if not found" do
      found_user = User.find_by_credentials("random_name", "1234")
      expect(found_user).to be_nil
    end
  end
end