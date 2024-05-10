RSpec.describe "account settings page" do
    describe "POST /update-profile" do
        it "updates users username and email" do
            post '/create-account', {
                username: 'testuser',
                password: 'Testpassword',
                confirm_password: 'Testpassword',
                dob: '1990-01-01',
                email: 'test1@example.com',
                account_type: 'reader'
            }

            post "/update-profile", { 
                username: "new_username",
                email: "new_email@example.com"
            }

            user = User.last
            expect(last_response).to be_ok
            expect(user.username).to eq("new_username")
            expect(user.email).to eq("new_email@example.com")
        end
    end

    describe "POST /change-password" do
        it "changes the users password" do
            post '/create-account', {
                username: 'testuser',
                password: 'Testpassword',
                confirm_password: 'Testpassword',
                dob: '1990-01-01',
                email: 'test1@example.com',
                account_type: 'reader'
            }

            post '/change-password', {
                currentPassword: 'Testpassword',
                newPassword: 'Newpassword',
                confirmPassword: 'Newpassword'
            }

            user = User.last
            expect(last_response).to be_ok
            expect(user.password).to eq("Newpassword")
        end
    end

    describe "post /delete-self" do
        it "deletes the account that selects it" do
            post '/create-account', {
                username: 'testuser',
                password: 'Testpassword',
                confirm_password: 'Testpassword',
                dob: '1990-01-01',
                email: 'test1@example.com',
                account_type: 'reader'
            }

            post '/delete-self'

            expect(last_response).to be_redirect
        end
    end
end