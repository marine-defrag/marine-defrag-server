# frozen_string_literal: true

require "rails_helper"
require "json"

RSpec.describe "measure_type to taxonomy relationships", type: :request do
  let(:auth_headers) do
    {
      "access-token" => token.token,
      "client" => token.client,
      "uid" => user.uid
    }
  end
  let!(:user) { FactoryBot.create(:user, :admin, password: "password") }
  let!(:token) { user.create_token }

  before { user.save }
  describe "get one measure_type/taxonomy relationship" do
    let!(:measure_type_taxonomy) { FactoryBot.create(:measure_type_taxonomy) }
    it "returns the measure_type/taxonomy releationship requested" do
      get "/measure_types_taxonomies/#{measure_type_taxonomy.id}", headers: auth_headers

      expected_json =
        {"data" =>
          {"id" => measure_type_taxonomy.id.to_s,
           "type" => "measure_type_taxonomies",
           "attributes" =>
            {"created_at" => measure_type_taxonomy.created_at.in_time_zone.iso8601,
             "updated_at" => measure_type_taxonomy.updated_at.in_time_zone.iso8601,
             "measure_type_id" => measure_type_taxonomy.measure_type_id,
             "taxonomy_id" => measure_type_taxonomy.taxonomy_id}}}

      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json).to eq(expected_json)
    end
  end

  describe "get all the measure_type/taxonomy relationships" do
    let(:measure_type_1) { FactoryBot.create(:measure_type) }
    let(:measure_type_2) { FactoryBot.create(:measure_type) }
    let(:taxonomy_1) { FactoryBot.create(:taxonomy) }
    let(:taxonomy_2) { FactoryBot.create(:taxonomy) }
    let!(:measure_type_measure_type_1) { FactoryBot.create(:measure_type_taxonomy, measure_type_id: measure_type_1.id, taxonomy_id: taxonomy_1.id) }
    let!(:measure_type_measure_type_2) { FactoryBot.create(:measure_type_taxonomy, measure_type_id: measure_type_1.id, taxonomy_id: taxonomy_2.id) }
    let!(:measure_type_measure_type_3) { FactoryBot.create(:measure_type_taxonomy, measure_type_id: measure_type_2.id, taxonomy_id: taxonomy_1.id) }

    it "returns all the linkable measure_type/taxonomies" do
      get "/measure_types_taxonomies", headers: auth_headers

      expected_json =
        {"data" =>
          [
            {"id" => measure_type_measure_type_1.id.to_s,
             "type" => "measure_type_taxonomies",
             "attributes" =>
              {"created_at" => measure_type_measure_type_1.created_at.in_time_zone.iso8601,
               "updated_at" => measure_type_measure_type_1.updated_at.in_time_zone.iso8601,
               "measure_type_id" => measure_type_measure_type_1.measure_type_id,
               "taxonomy_id" => measure_type_measure_type_1.taxonomy_id}},
            {"id" => measure_type_measure_type_2.id.to_s,
             "type" => "measure_type_taxonomies",
             "attributes" =>
              {"created_at" => measure_type_measure_type_2.created_at.in_time_zone.iso8601,
               "updated_at" => measure_type_measure_type_2.updated_at.in_time_zone.iso8601,
               "measure_type_id" => measure_type_measure_type_2.measure_type_id,
               "taxonomy_id" => measure_type_measure_type_2.taxonomy_id}},
            {"id" => measure_type_measure_type_3.id.to_s,
             "type" => "measure_type_taxonomies",
             "attributes" =>
              {"created_at" => measure_type_measure_type_3.created_at.in_time_zone.iso8601,
               "updated_at" => measure_type_measure_type_3.updated_at.in_time_zone.iso8601,
               "measure_type_id" => measure_type_measure_type_3.measure_type_id,
               "taxonomy_id" => measure_type_measure_type_3.taxonomy_id}}
          ]}

      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json).to eq(expected_json)
    end
  end
end
