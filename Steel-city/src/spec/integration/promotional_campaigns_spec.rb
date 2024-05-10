RSpec.describe "Creating promotional campaigns route" do
    describe "post /create-prom-campaign" do
        it "creates promotional campaign successfully" do
            post "/create-prom-campaign", {
                "title" => "Test Campaign",
                "campaign-content" => "Test campaign content",
                "start-date" => "2077-07-07",
                "end-date" => "2077-07-08",
                "discount" => "0.2"
            }

            campaign = PromotionalCampaign.last
            expect(campaign.title).to eq("Test Campaign")
            expect(campaign.content).to eq("Test campaign content")
            expect(campaign.startdate).to eq("2077-07-07")
            expect(campaign.enddate).to eq("2077-07-08")
            expect(campaign.discount).to eq(0.2)
        end

        it "throws an error if start date is before now" do
            post "/create-prom-campaign", {
                "title" => "Test Campaign",
                "campaign-content" => "Test campaign content",
                "start-date" => "2000-07-07",
                "end-date" => "2077-07-08",
                "discount" => "0.2"
            }

            expect(last_response).to be_ok
            expect(last_response.body).to include("Invalid start date")
        end

        it "throws an error if end date is before now" do
            post "/create-prom-campaign", {
                "title" => "Test Campaign",
                "campaign-content" => "Test campaign content",
                "start-date" => "2077-07-07",
                "end-date" => "2000-07-08",
                "discount" => "0.2"
            }

            expect(last_response).to be_ok
            expect(last_response.body).to include("Invalid end date")
        end

        it "throws an error if end date is before start date" do
            post "/create-prom-campaign", {
                "title" => "Test Campaign",
                "campaign-content" => "Test campaign content",
                "start-date" => "2077-07-07",
                "end-date" => "2077-07-06",
                "discount" => "0.2"
            }

            expect(last_response).to be_ok
            expect(last_response.body).to include("Campaign ends before start date")
        end
    end

    
end