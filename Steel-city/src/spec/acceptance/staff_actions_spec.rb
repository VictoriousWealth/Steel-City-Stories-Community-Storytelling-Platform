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

    context "when an admin searches for a user then deletes them" do
        it "deletes the user from the data base" do

            visit '/create-account'
            fill_in 'username', with: 'testuser'
            fill_in 'password', with: 'Testpassword'
            fill_in 'confirm_password', with: 'Testpassword'
            fill_in 'dob', with: '1990-01-01'
            fill_in 'email', with: 'test1@example.com'
            choose "reader"
            click_button('Create Account')

            click_link('Logout')

            visit '/login'
            fill_in 'username', with: 'admin'
            fill_in 'password', with: 'admin'
            click_button('Submit')

            visit '/staff-actions'
            fill_in 'username', with: 'testuser'
            click_button('Find User')

            click_button "Delete Account"

            fill_in 'username', with: 'testuser'
            click_button('Find User')

            expect(page).to have_content('No users found.')
        end
    end

    context "when an admin searches for a user then changes there popcorn" do
        it "changes their popcorn" do

            visit '/create-account'
            fill_in 'username', with: 'testuser'
            fill_in 'password', with: 'Testpassword'
            fill_in 'confirm_password', with: 'Testpassword'
            fill_in 'dob', with: '1990-01-01'
            fill_in 'email', with: 'test1@example.com'
            choose "reader"
            click_button('Create Account')

            click_link('Logout')

            visit '/login'
            fill_in 'username', with: 'admin'
            fill_in 'password', with: 'admin'
            click_button('Submit')

            visit '/staff-actions'
            fill_in 'username', with: 'testuser'
            click_button('Find User')

            fill_in 'popcorns', with: '20'
            click_button "Change Popcorns"

            fill_in 'username', with: 'testuser'
            click_button('Find User')

            expect(page).to have_content('Current popcorns: 20')
        end
    end
end