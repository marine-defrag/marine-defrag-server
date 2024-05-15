require "rails_helper"
require "json"

RSpec.describe FeedbacksController, type: :controller do
  describe "POST create" do
    context "when not signed in" do
      it "not allow creating a feedback" do
        post :create, format: :json, params: {feedback: {subject: "Test", content: "Test"}}
        expect(response).to be_unauthorized
      end
    end


  end
end
