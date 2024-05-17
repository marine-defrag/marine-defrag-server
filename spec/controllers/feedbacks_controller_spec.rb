require "rails_helper"
require "json"

RSpec.describe FeedbacksController, type: :controller do
  describe "POST create" do
    subject do
      post :create,
        format: :json,
        params: {feedback: {subject: "Test Subject", content: "Test Content"}}
    end

    context "when not signed in" do
      it "not allow creating a feedback" do
        expect(subject).to be_unauthorized
      end

      it "will not send a notification" do
        expect(FeedbackMailer).not_to receive(:created)

        subject
      end
    end

    context "when signed in" do
      before { sign_in user }

      context "as a guest" do
        let(:user) { FactoryBot.create(:user) }

        it "will create a feedback" do
          expect(subject).to be_created
          json = JSON.parse(subject.body)
          expect(json["data"]["attributes"]["user_id"]).to eq(user.id)
        end

        it "will send a notification" do
          expect(FeedbackMailer).to receive(:created).and_call_original

          subject
        end
      end

      context "as an analyst" do
        let(:user) { FactoryBot.create(:user, :analyst) }

        it "will create a feedback" do
          expect(subject).to be_created
          json = JSON.parse(subject.body)
          expect(json["data"]["attributes"]["user_id"]).to eq(user.id)
        end

        it "will send a notification" do
          expect(FeedbackMailer).to receive(:created).and_call_original

          subject
        end
      end

      context "as an admin" do
        let(:user) { FactoryBot.create(:user, :admin) }

        it "will create a feedback" do
          expect(subject).to be_created
          json = JSON.parse(subject.body)
          expect(json["data"]["attributes"]["user_id"]).to eq(user.id)
        end

        it "will send a notification" do
          expect(FeedbackMailer).to receive(:created).and_call_original

          subject
        end
      end

      context "as a manager" do
        let(:user) { FactoryBot.create(:user, :manager) }

        it "will create a feedback" do
          expect(subject).to be_created
          json = JSON.parse(subject.body)
          expect(json["data"]["attributes"]["user_id"]).to eq(user.id)
        end

        it "will send a notification" do
          expect(FeedbackMailer).to receive(:created).and_call_original

          subject
        end
      end
    end
  end
end
