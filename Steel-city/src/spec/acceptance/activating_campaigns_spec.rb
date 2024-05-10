RSpec.describe "Campaign activation" do
    context "when an active discount is available and activated" do
        it "applies a discount to the applicable user" do

            visit '/login'
            fill_in 'username', with: 'admin'
            fill_in 'password', with: 'admin'
            click_button('Submit')

            today = Date.today
            start_date = today.strftime("%Y-%m-%d")
            finish_date = "2027-01-01"

            visit '/staff-actions'
            fill_in 'title', with: 'test campaign'
            fill_in 'campaign-content', with: 'this is a campaign'
            fill_in 'start-date', with: "#{start_date}"
            fill_in 'end-date', with: "#{finish_date}"
            fill_in 'discount', with: '0.2'
            click_button('Create Campaign')

            click_link('Logout')

            visit '/create-account'
            fill_in 'username', with: 'testuser'
            fill_in 'password', with: 'Testpassword'
            fill_in 'confirm_password', with: 'Testpassword'
            fill_in 'dob', with: '1990-01-01'
            fill_in 'email', with: 'test1@example.com'
            choose "reader"
            click_button('Create Account')

            user = User.last
            user.interactions = 1000
            user.save_changes

            visit '/'
            click_link('Activate')

            expect(page).to be_ok
        end
    end
end