# frozen_string_literal: true

require "rails_helper"
require "json"

RSpec.describe "actor_type to taxonomy relationships", type: :request do
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
  describe "get one actor_type/taxonomy relationship" do
    let!(:actor_type_taxonomy) { FactoryBot.create(:actor_type_taxonomy) }
    it "returns the actor_type/taxonomy releationship requested" do
      get "/actor_types_taxonomies/#{actor_type_taxonomy.id}", headers: auth_headers

      expected_json =
        {"data" =>
          {"id" => actor_type_taxonomy.id.to_s,
           "type" => "actor_type_taxonomies",
           "attributes" =>
            {"created_at" => actor_type_taxonomy.created_at.in_time_zone.iso8601,
             "updated_at" => actor_type_taxonomy.updated_at.in_time_zone.iso8601,
             "actor_type_id" => actor_type_taxonomy.actor_type_id,
             "taxonomy_id" => actor_type_taxonomy.taxonomy_id}}}

      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json).to eq(expected_json)
    end
  end

  describe "get all the actor_type/taxonomy relationships" do
    let(:actor_type_1) { FactoryBot.create(:actor_type) }
    let(:actor_type_2) { FactoryBot.create(:actor_type) }
    let(:taxonomy_1) { FactoryBot.create(:taxonomy) }
    let(:taxonomy_2) { FactoryBot.create(:taxonomy) }
    let!(:actor_type_actor_type_1) { FactoryBot.create(:actor_type_taxonomy, actor_type_id: actor_type_1.id, taxonomy_id: taxonomy_1.id) }
    let!(:actor_type_actor_type_2) { FactoryBot.create(:actor_type_taxonomy, actor_type_id: actor_type_1.id, taxonomy_id: taxonomy_2.id) }
    let!(:actor_type_actor_type_3) { FactoryBot.create(:actor_type_taxonomy, actor_type_id: actor_type_2.id, taxonomy_id: taxonomy_1.id) }

    it "returns all the linkable actor_type/taxonomies" do
      get "/actor_types_taxonomies", headers: auth_headers

      expected_json =
        {"data" =>
          [
            {"id" => actor_type_actor_type_1.id.to_s,
             "type" => "actor_type_taxonomies",
             "attributes" =>
              {"created_at" => actor_type_actor_type_1.created_at.in_time_zone.iso8601,
               "updated_at" => actor_type_actor_type_1.updated_at.in_time_zone.iso8601,
               "actor_type_id" => actor_type_actor_type_1.actor_type_id,
               "taxonomy_id" => actor_type_actor_type_1.taxonomy_id}},
            {"id" => actor_type_actor_type_2.id.to_s,
             "type" => "actor_type_taxonomies",
             "attributes" =>
              {"created_at" => actor_type_actor_type_2.created_at.in_time_zone.iso8601,
               "updated_at" => actor_type_actor_type_2.updated_at.in_time_zone.iso8601,
               "actor_type_id" => actor_type_actor_type_2.actor_type_id,
               "taxonomy_id" => actor_type_actor_type_2.taxonomy_id}},
            {"id" => actor_type_actor_type_3.id.to_s,
             "type" => "actor_type_taxonomies",
             "attributes" =>
              {"created_at" => actor_type_actor_type_3.created_at.in_time_zone.iso8601,
               "updated_at" => actor_type_actor_type_3.updated_at.in_time_zone.iso8601,
               "actor_type_id" => actor_type_actor_type_3.actor_type_id,
               "taxonomy_id" => actor_type_actor_type_3.taxonomy_id}}
          ]}

      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json).to eq(expected_json)
    end
  end
end
