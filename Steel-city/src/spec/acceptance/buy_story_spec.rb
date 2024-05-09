RSpec.describe "Buying a story as a user" do
    context "when a user creates an account and buys a story" do
        it "displays the story that has been bought" do
        
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

            click_link('Logout')

            visit '/login'
            fill_in 'username', with: 'testuser'
            fill_in 'password', with: 'Testpassword'
            click_button('Submit')
            
            click_link "title"

            buy_button = find('button', text: 'Buy Story')
            buy_button.click
            
            save_page
            expect(page).to have_content('Thank you for purchasing')
        end
    end
end