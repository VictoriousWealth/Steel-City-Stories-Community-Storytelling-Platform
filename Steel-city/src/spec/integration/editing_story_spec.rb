RSpec.describe "Editing story route" do
    describe "GET /edit-story" do
        it "displays a form to edit details of story" do
        get "/edit-story/1"
        expect(last_response).to be_ok
        expect(last_response.body).to include("Write Your Story")
        end
    end

    describe "POST /edit-story" do
        it "edits the content of the story for other users" do
            post '/submit-story', {
                "story-title" => "Test Title",
                "story-content" => "Test story content", 
                "genre" => "fiction", 
                "blurb-content" => "Test blurb content",
                "price" => "10"
            }

            story = Story.last
            storyid = story.storyid

            post "/edit-story/#{storyid}", {
                "story-title" => "Test Title Edited",
                "story-content" => "Test story content edited", 
                "genre" => "fiction", 
                "blurb-content" => "Test blurb content",
                "price" => "10"
            }

            expect(last_response).to be_redirect
            follow_redirect!

            expect(last_response).to be_ok
            expect(last_response.body).to include('Test Title Edited')
            expect(last_response.body).to include('Test story content edited')
        end
    end
end