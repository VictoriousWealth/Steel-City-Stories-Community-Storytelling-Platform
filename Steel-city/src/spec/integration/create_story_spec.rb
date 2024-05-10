RSpec.describe "Creating story route" do
    describe "GET /create-story" do
        it "displays a blank form to write details of story" do
          get "/create-story"
          expect(last_response).to be_ok
          expect(last_response.body).to include("Write Your Story")
        end
    end

    describe "POST /submit-story" do
        it "creates a story that can be viewed by other users" do
            post '/submit-story', {
                "story-title" => "Test Title",
                "story-content" => "Test story content", 
                "genre" => "fiction", 
                "blurb-content" => "Test blurb content",
                "price" => "10",
                "language" => "en"
            }

            expect(last_response).to be_redirect
            follow_redirect!

            expect(last_response).to be_ok
            expect(last_response.body).to include('Test Title')
            expect(last_response.body).to include('Test story content')
        end
    end
end