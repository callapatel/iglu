require 'spec_helper'

describe User do
  let(:user){ User.new(
    username: "Calla",
    name: "Calla",
    token: "123",
    uid: "1235456",
    )
    }

    describe "validations" do
      it "is valid" do
        expect(user).to be_valid
      end
      it "requires a username" do
        user.username = nil
        expect(user).to be_invalid
      end
      it "requires a uid" do
        user.uid = nil
        expect(user).to be_invalid
      end
      it "requires a name" do
        user.name = nil
        expect(user).to be_invalid
      end
      it "requires a token" do
        user.token = nil
        expect(user).to be_invalid
      end
    end
    describe ".initialize_from_omniauth" do
      let(:user) {
        User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:instagram])
        }
      it "creates a valid user" do
        expect(user).to be_valid
      end
      context "when it's invalid" do
        it "returns nil" do
          user = User.find_or_create_from_omniauth({"uid" => "123", "info" => {}})
          expect(user).to be_nil
        end
      end
    end
  end
