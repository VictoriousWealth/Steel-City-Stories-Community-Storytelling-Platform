RSpec.describe "Staff tickets route" do
    describe "POST /send-form" do
        context "when the user reports a story" do
            it "displays the report in the staff action page" do
                post "/send-form", {
                    "email" => "home@home.com",
                    "formember" => "test",
                    "feedback" => "test"
                }

                expect(last_response).to be_ok
                expect(last_response.body).to include("Contact Form:")
            end
        end
    end
end