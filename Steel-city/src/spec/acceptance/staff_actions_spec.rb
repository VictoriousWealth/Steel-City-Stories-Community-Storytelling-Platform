RSpec.describe "Staff actions performed by admin" do
    context "when an admin searches for a user" do
      it "displays that user if found" do
        
        visit '/login'
        fill_in 'username', with: 'admin'
        fill_in 'password', with: 'admin'
        click_button('Submit')

        visit '/staff-actions'
        fill_in 'username', with: 'writer'
        click_button('Find User')

        expect(page).to have_content('Found User: writer')
      end
    end

    context "when an admin searches for a story" do
        it "displays that story if found" do

            visit '/login'
            fill_in 'username', with: 'admin'
            fill_in 'password', with: 'admin'
            click_button('Submit')

            visit '/staff-actions'
            fill_in 'storyid', with: '10'
            click_button('Find Story')

            expect(page).to have_content('Story found: The hobbit - An unexpected party - chapter 1')
        end
    end
end