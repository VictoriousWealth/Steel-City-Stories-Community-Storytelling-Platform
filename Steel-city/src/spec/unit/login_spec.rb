RSpec.describe "Login controller" do
    describe "POST /login" do
        context "with no login details" do
            it "tells the user the details are incorrect" do
                post "/login"
                expect(last_response).to be_ok
                expect(last_response.body).to include("Please ensure all fields have been filled in")
            end
        end

        context "with incorrect Username" do
            it "tells the user the username is incorrect" do
                post "/login", "username" => "wrong_user", "password" => "test"
                expect(last_response).to be_ok
                expect(last_response.body).to include("Username incorrect")
            end
        end

        context "with correct username but incorrect password" do
            it "tells the user the password is incorrect" do
                post "/login", "username" => "test", "password" => "wrong_password"
                expect(last_response).to be_ok
                expect(last_response.body).to include("Password incorrect")
            end
        end

        context "with correct login details" do
            it "redirects to the secure area page" do
                post "/login", "username" => "staff", "password" => "12345"
                expect(last_response).to be_redirect
                expect(last_response.location).to end_with("/")
            end
        end
    end
end