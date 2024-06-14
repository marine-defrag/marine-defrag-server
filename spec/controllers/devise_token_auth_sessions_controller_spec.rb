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

    context "when user is archived" do
      let(:user) { FactoryBot.create(:user, :archived) }

      it "does not allow sign in" do
        expect(subject).to have_http_status(:unauthorized)
      end

      it "returns an error message" do
        subject

        expect(JSON.parse(response.body).dig("errors"))
          .to include(I18n.t("devise.mailer.unlock_instructions.account_lock_msg"))
      end
    end
  end
end
