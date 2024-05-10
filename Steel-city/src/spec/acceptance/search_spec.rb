RSpec.describe "Searching for stories" do
    context "when a user searches for a story that is there" do
      it "then shows the story on the search page" do
        
        visit '/'
        fill_in 'q', with: 'The life of a yapper'
        find('button[type="submit"]').click
  
        expect(page).to have_content "The life of a yapper"
      end
    end

    context "when a user searches for a story that doesn't exist" do
      it "doesn't display any stories" do

        visit '/'
        fill_in 'q', with: 'not a story'
        find('button[type="submit"]').click

        expect(page).to have_content "No results found."
      end
    end

    context "when a user searches for another user" do
      it "displays their username if found" do

        visit '/'
        fill_in 'q', with: 'writer'
        find('button[type="submit"]').click

        expect(page).to have_content "writer"
      end
    end

    context "when a user searches for a story that doesn't exist" do
      it "doesn't display any stories" do

        visit '/'
        fill_in 'q', with: 'writer'
        find('button[type="submit"]').click

        expect(page).to have_content "No results found."
      end
    end
end