RSpec.describe "Creating polls route" do
    describe "GET /create poll" do
        it "displays a blank form to fill in poll details" do
            post '/submit-story', {
                "story-title" => "Test Title",
                "story-content" => "Test story content", 
                "genre" => "fiction", 
                "blurb-content" => "Test blurb content",
                "price" => "10",
                "language" => "en"
            }

            story = Story.last
            story_id = story.storyid

            get "/add-poll/:#{story_id}"

            expect(last_response).to be_ok
        end
    end

    describe "POST /create-poll/:storyid" do
        it "creates a story that can be viewed by other users" do
            
            post '/submit-story', {
                "story-title" => "Test Title",
                "story-content" => "Test story content", 
                "genre" => "fiction", 
                "blurb-content" => "Test blurb content",
                "price" => "10",
                "language" => "en"
            }

            story = Story.last
            story_id = story.storyid

            post "/create-poll/:#{story_id}", {
                "poll_question" => "this is a poll question",
                "optionsnum" => "1"
            }

            expect(last_response).to be_ok
        end
    end
end