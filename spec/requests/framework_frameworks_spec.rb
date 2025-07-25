# frozen_string_literal: true

require "rails_helper"
require "json"

RSpec.describe "framework to framework relationships", type: :request do
  let(:auth_headers) do
    {
      "access-token" => token.token,
      "client" => token.client,
      "uid" => user.uid
    }
  end
  let(:user) { FactoryBot.create(:user, :admin, password: "1lj#hIKekU17") }
  let!(:token) { user.create_token }

  before { user.save }

  describe "get one framework relationship" do
    let(:framework_framework) { FactoryBot.create(:framework_framework) }
    it "returns the framework releationship requested" do
      get "/framework_frameworks/#{framework_framework.id}", headers: auth_headers

      expected_json =
        {"data" =>
          {"id" => framework_framework.id.to_s,
           "type" => "framework_frameworks",
           "attributes" =>
            {"created_at" => framework_framework.created_at.in_time_zone.iso8601,
             "updated_at" => framework_framework.updated_at.in_time_zone.iso8601,
             "framework_id" => framework_framework.framework_id,
             "other_framework_id" => framework_framework.other_framework_id}}}

      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json).to eq(expected_json)
    end
  end

  describe "get all the framework relationships" do
    let(:framework_1) { FactoryBot.create(:framework) }
    let(:framework_2) { FactoryBot.create(:framework) }
    let(:framework_3) { FactoryBot.create(:framework) }
    let!(:framework_framework_1) { FactoryBot.create(:framework_framework, framework_id: framework_1.id, other_framework_id: framework_2.id) }
    let!(:framework_framework_2) { FactoryBot.create(:framework_framework, framework_id: framework_2.id, other_framework_id: framework_3.id) }
    let!(:framework_framework_3) { FactoryBot.create(:framework_framework, framework_id: framework_1.id, other_framework_id: framework_3.id) }

    it "returns all the linkable frameworks" do
      get "/framework_frameworks", headers: auth_headers

      expected_json =
        {"data" =>
          [
            {"id" => framework_framework_1.id.to_s,
             "type" => "framework_frameworks",
             "attributes" =>
              {"created_at" => framework_framework_1.created_at.in_time_zone.iso8601,
               "updated_at" => framework_framework_1.updated_at.in_time_zone.iso8601,
               "framework_id" => framework_framework_1.framework_id,
               "other_framework_id" => framework_framework_1.other_framework_id}},
            {"id" => framework_framework_2.id.to_s,
             "type" => "framework_frameworks",
             "attributes" =>
              {"created_at" => framework_framework_2.created_at.in_time_zone.iso8601,
               "updated_at" => framework_framework_2.updated_at.in_time_zone.iso8601,
               "framework_id" => framework_framework_2.framework_id,
               "other_framework_id" => framework_framework_2.other_framework_id}},
            {"id" => framework_framework_3.id.to_s,
             "type" => "framework_frameworks",
             "attributes" =>
              {"created_at" => framework_framework_3.created_at.in_time_zone.iso8601,
               "updated_at" => framework_framework_3.updated_at.in_time_zone.iso8601,
               "framework_id" => framework_framework_3.framework_id,
               "other_framework_id" => framework_framework_3.other_framework_id}}
          ]}

      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json).to eq(expected_json)
    end
  end
end
