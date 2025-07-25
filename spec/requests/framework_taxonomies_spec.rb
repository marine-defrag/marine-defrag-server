# frozen_string_literal: true

require "rails_helper"
require "json"

RSpec.describe "framework to taxonomy relationships", type: :request do
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
  describe "get one framework/taxonomy relationship" do
    let!(:framework_taxonomy) { FactoryBot.create(:framework_taxonomy) }
    it "returns the framework/taxonomy releationship requested" do
      get "/framework_taxonomies/#{framework_taxonomy.id}", headers: auth_headers

      expected_json =
        {"data" =>
          {"id" => framework_taxonomy.id.to_s,
           "type" => "framework_taxonomies",
           "attributes" =>
            {"created_at" => framework_taxonomy.created_at.in_time_zone.iso8601,
             "updated_at" => framework_taxonomy.updated_at.in_time_zone.iso8601,
             "framework_id" => framework_taxonomy.framework_id,
             "taxonomy_id" => framework_taxonomy.taxonomy_id}}}

      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json).to eq(expected_json)
    end
  end

  describe "get all the framework/taxonomy relationships" do
    let(:framework_1) { FactoryBot.create(:framework) }
    let(:framework_2) { FactoryBot.create(:framework) }
    let(:taxonomy_1) { FactoryBot.create(:taxonomy) }
    let(:taxonomy_2) { FactoryBot.create(:taxonomy) }
    let!(:framework_framework_1) { FactoryBot.create(:framework_taxonomy, framework_id: framework_1.id, taxonomy_id: taxonomy_1.id) }
    let!(:framework_framework_2) { FactoryBot.create(:framework_taxonomy, framework_id: framework_1.id, taxonomy_id: taxonomy_2.id) }
    let!(:framework_framework_3) { FactoryBot.create(:framework_taxonomy, framework_id: framework_2.id, taxonomy_id: taxonomy_1.id) }

    it "returns all the linkable framework/taxonomies" do
      get "/framework_taxonomies", headers: auth_headers

      expected_json =
        {"data" =>
          [
            {"id" => framework_framework_1.id.to_s,
             "type" => "framework_taxonomies",
             "attributes" =>
              {"created_at" => framework_framework_1.created_at.in_time_zone.iso8601,
               "updated_at" => framework_framework_1.updated_at.in_time_zone.iso8601,
               "framework_id" => framework_framework_1.framework_id,
               "taxonomy_id" => framework_framework_1.taxonomy_id}},
            {"id" => framework_framework_2.id.to_s,
             "type" => "framework_taxonomies",
             "attributes" =>
              {"created_at" => framework_framework_2.created_at.in_time_zone.iso8601,
               "updated_at" => framework_framework_2.updated_at.in_time_zone.iso8601,
               "framework_id" => framework_framework_2.framework_id,
               "taxonomy_id" => framework_framework_2.taxonomy_id}},
            {"id" => framework_framework_3.id.to_s,
             "type" => "framework_taxonomies",
             "attributes" =>
              {"created_at" => framework_framework_3.created_at.in_time_zone.iso8601,
               "updated_at" => framework_framework_3.updated_at.in_time_zone.iso8601,
               "framework_id" => framework_framework_3.framework_id,
               "taxonomy_id" => framework_framework_3.taxonomy_id}}
          ]}

      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json).to eq(expected_json)
    end
  end
end
