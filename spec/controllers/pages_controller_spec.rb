require "rails_helper"
require "json"

RSpec.describe PagesController, type: :controller do
  describe "Get index" do
    subject { get :index, format: :json }
    let!(:page) { FactoryBot.create(:page) }
    let!(:draft_page) { FactoryBot.create(:page, draft: true, private: true) }
    let!(:private_page) { FactoryBot.create(:page, private: true, draft: false) }
    let!(:public_page) { FactoryBot.create(:page, private: false, draft: false) }

    context "when not signed in" do
      it "returns only public and non-draft pages" do
        subject  # Makes the request to the index action

        # Parse the JSON response
        json_response = JSON.parse(response.body)

        # Check if all pages in the response are not draft and not private
        expect(json_response["data"].all? do |page|
          page["attributes"]["draft"] == false && page["attributes"]["private"] == false
        end).to be true
      end
    end
    context "when signed in" do
      let(:user) { FactoryBot.create(:user, :manager) } # You can change role as needed (admin, analyst)

      before { sign_in user }

      it "returns all pages for admin/manager" do
        subject
        json_response = JSON.parse(response.body)

        # Check that all pages are returned (draft, private, etc.)
        expect(json_response["data"].length).to eq(4)
      end

      context "as an analyst" do
        let(:analyst) { FactoryBot.create(:user, :analyst) }

        before { sign_in analyst }

        it "returns only non-draft pages" do
          subject
          json_response = JSON.parse(response.body)

          # Check that draft pages are excluded
          expect(json_response["data"].all? { |page| page["attributes"]["draft"] == false }).to be true
        end
      end
    end
  end

  describe "Get show" do
    let!(:page) { FactoryBot.create(:page) }
    let!(:draft_page) { FactoryBot.create(:page, draft: true, private: true) }
    let!(:private_page) { FactoryBot.create(:page, private: true, draft: false) }
    let!(:public_page) { FactoryBot.create(:page, private: false, draft: false) }

    context "when not signed in" do
      it "does not allow access to draft pages" do
        get :show, params: { id: draft_page }, format: :json
        expect(response).to be_not_found
      end

      it "does not allow access to private pages" do
        get :show, params: { id: private_page }, format: :json
        expect(response).to be_not_found
      end

      it "allows access to public pages" do
        get :show, params: { id: public_page }, format: :json
        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response["data"]["attributes"]["draft"]).to be false
        expect(json_response["data"]["attributes"]["private"]).to be false
      end
    end

    context "when signed in" do
      let(:user) { FactoryBot.create(:user, :manager) } # Change role as needed

      before { sign_in user }

      it "allows managers to access all pages" do
        [page, draft_page, private_page, public_page].each do |p|
          get :show, params: { id: p }, format: :json
          expect(response).to have_http_status(:ok)
        end
      end

      context "as an analyst" do
        let(:analyst) { FactoryBot.create(:user, :analyst) }

        before { sign_in analyst }

        it "allows access to non-draft pages but not drafts" do
          get :show, params: { id: public_page }, format: :json
          expect(response).to have_http_status(:ok)

          get :show, params: { id: private_page }, format: :json
          expect(response).to have_http_status(:ok)

          get :show, params: { id: draft_page }, format: :json
          expect(response).to be_not_found
        end
      end
    end
  end



  describe "Post create" do
    context "when not signed in" do
      it "not allow creating a page" do
        post :create, format: :json, params: {page: {title: "test", description: "test", target_date: "today"}}
        expect(response).to be_unauthorized
      end
    end

    context "when signed in" do
      let(:admin) { FactoryBot.create(:user, :admin) }
      let(:guest) { FactoryBot.create(:user) }
      let(:manager) { FactoryBot.create(:user, :manager) }
      let(:taxonomy) { FactoryBot.create(:taxonomy) }

      subject do
        post :create,
          format: :json,
          params: {
            page: {
              title: "test",
              content: "bla",
              menu_title: "test",
              document_url: "test.example.com"
            }
          }
      end

      it "will not allow a guest to create a page" do
        sign_in guest
        expect(subject).to be_forbidden
      end

      it "will allow a manager to create a page" do
        sign_in manager
        expect(subject).to be_created
      end

      it "will not allow an admin to create a page" do
        sign_in admin
        expect(subject).to be_created
      end

      it "will record what manager created the page", versioning: true do
        expect(PaperTrail).to be_enabled
        sign_in admin
        json = JSON.parse(subject.body)
        expect(json["data"]["attributes"]["updated_by_id"].to_i).to eq admin.id
      end

      it "will return an error if params are incorrect" do
        sign_in admin
        post :create, format: :json, params: {page: {description: "desc only", taxonomy_id: 999}}
        expect(response).to have_http_status(422)
      end

      it "will store the document_url" do
        sign_in admin
        json = JSON.parse(subject.body)
        expect(json["data"]["attributes"]["document_url"]).to eq("test.example.com")
      end
    end
  end

  describe "PUT update" do
    let(:page) { FactoryBot.create(:page) }
    subject do
      put :update,
        format: :json,
        params: {
          id: page,
          page: {
            title: "test update",
            description: "test update",
            target_date: "today update"
          }
        }
    end

    context "when not signed in" do
      it "not allow updating a page" do
        expect(subject).to be_unauthorized
      end
    end

    context "when user signed in" do
      let(:admin) { FactoryBot.create(:user, :admin) }
      let(:guest) { FactoryBot.create(:user) }
      let(:manager) { FactoryBot.create(:user, :manager) }

      it "will not allow a guest to update a page" do
        sign_in guest
        expect(subject).to be_forbidden
      end

      it "will allow a manager to update a page" do
        sign_in manager
        expect(subject).to be_ok
      end

      it "will allow an admin to update a page" do
        sign_in admin
        expect(subject).to be_ok
      end

      it "will reject and update where the last_updated_at is older than updated_at in the database" do
        sign_in admin
        page_get = get :show, params: {id: page}, format: :json
        json = JSON.parse(page_get.body)
        current_update_at = json["data"]["attributes"]["updated_at"]

        Timecop.travel(Time.new + 15.days) do
          subject = put :update,
            format: :json,
            params: {
              id: page,
              page: {
                title: "test update",
                description: "test updateeee",
                target_date: "today update",
                updated_at: current_update_at
              }
            }
          expect(subject).to be_ok
        end
        Timecop.travel(Time.new + 5.days) do
          subject = put :update,
            format: :json,
            params: {
              id: page,
              page: {
                title: "test update",
                description: "test updatebbbb",
                target_date: "today update",
                updated_at: current_update_at
              }
            }
          expect(subject).to_not be_ok
        end
      end

      it "will record what manager updated the page", versioning: true do
        expect(PaperTrail).to be_enabled
        sign_in admin
        json = JSON.parse(subject.body)
        expect(json["data"]["attributes"]["updated_by_id"].to_i).to eq admin.id
      end

      it "will return the latest updated_by", versioning: true do
        expect(PaperTrail).to be_enabled
        page.versions.first.update_column(:whodunnit, manager.id)
        sign_in admin
        json = JSON.parse(subject.body)
        expect(json["data"]["attributes"]["updated_by_id"].to_i).to eq(admin.id)
      end
    end
  end

  describe "Delete destroy" do
    let(:page) { FactoryBot.create(:page) }
    subject { delete :destroy, format: :json, params: {id: page} }

    context "when not signed in" do
      it "not allow deleting a page" do
        expect(subject).to be_unauthorized
      end
    end

    context "when user signed in" do
      let(:admin) { FactoryBot.create(:user, :admin) }
      let(:guest) { FactoryBot.create(:user) }
      let(:manager) { FactoryBot.create(:user, :manager) }

      it "will not allow a guest to delete a page" do
        sign_in guest
        expect(subject).to be_forbidden
      end

      it "will allow a manager to delete a page" do
        sign_in manager
        expect(subject).to be_no_content
      end

      it "will allow an admin to delete a page" do
        sign_in admin
        expect(subject).to be_no_content
      end
    end
  end
end
