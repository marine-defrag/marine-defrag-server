require "rails_helper"

RSpec.describe "DeviseTokenAuth::Sessions", type: :request do
  describe "POST /auth/sign_in" do
    let(:password) { "1lj#hIKekU17" }

    context "when user is active" do
      let(:user) { FactoryBot.create(:user, :active, password: password) }

      it "allows sign in" do
        post "/auth/sign_in", params: { email: user.email, password: password }
        expect(response).to have_http_status(:success)
      end
    end

    context "when user is archived" do
      let(:user) { FactoryBot.create(:user, :archived, password: password) }

      it "does not allow sign in" do
        post "/auth/sign_in", params: { email: user.email, password: password }
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns an error message" do
        post "/auth/sign_in", params: { email: user.email, password: password }
        expect(JSON.parse(response.body)["error"])
          .to include(I18n.t("devise.failure.archived"))
      end
    end
  end
end
