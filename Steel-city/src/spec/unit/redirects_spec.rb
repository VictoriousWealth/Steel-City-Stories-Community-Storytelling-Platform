RSpec.describe "page redirects" do
    describe "GET /store" do
      context "when clicking on the link to the store" do
        it "redirects you to the store page" do
          get "/store"
          expect(last_response.status).to eq(200)
        end
      end
    end
  
    describe "GET /promotions" do
        context "when clicking on the link to the promotions page" do
          it "redirects you to the promotions page" do
            get "/promotions"
            expect(last_response.status).to eq(200)
          end
        end
    end

    describe "GET /create-story" do
      context "when clicking on the link to the story creation" do
        it "redirects you to the create a story page" do
          get "/create-story"
          expect(last_response.status).to eq(200)
        end
      end
    end

    describe "GET /staff-actions" do
      context "when clicking on the link to the staff actions page" do
        it "redirects you to the staff actions page" do
          get "/staff-actions"
          expect(last_response.status).to eq(200)
        end
      end
    end

    describe "GET /staff-tickets" do
      context "when clicking on a ticket " do
        it "redirects you to the staff ticket page" do
          get "/staff-tickets"
          expect(last_response.status).to eq(200)
        end
      end
    end

    describe "GET /logout" do
      context "when clicking on logout" do
        it "redirects you to the home page logged out" do
          get "/logout"
          expect(last_response.status).to eq(302)
        end
      end
    end

    describe "GET /account" do
        context "when clicking on the link to the account settings page" do
          it "redirects you to the account settings page" do
            get "/account-settings"
            expect(last_response.status).to eq(200)
          end
        end
      end
end