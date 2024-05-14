require "rails_helper"

RSpec.describe DeviseTokenAuth::SessionsController, type: :controller do
  describe "POST #create" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    subject do
      post :create, params: {email: user.email, password: "password"}
    end

    context "when user is active" do
      let(:user) { FactoryBot.create(:user, :active) }

      it "allows sign in" do
        expect(subject).to have_http_status(:success)
      end
    end

    context "when user is inactive" do
      let(:user) { FactoryBot.create(:user, :inactive) }

      it "does not allow sign in" do
        expect(subject).to have_http_status(:unauthorized)
      end
    end
  end
end
