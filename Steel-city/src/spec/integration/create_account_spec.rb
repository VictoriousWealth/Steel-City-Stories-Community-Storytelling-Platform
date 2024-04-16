RSpec.describe "Creating account route" do
    describe "GET /create-account" do
        it "displays a blank form" do
          get "/create-account"
          expect(last_response).to be_ok
          expect(last_response.body).to include("Create account")
        end
    end

    describe "POST /create-account" do
        it "creates a user account successfully" do
            post '/create-account', {
                username: 'testuser',
                password: 'Testpassword',
                confirm_password: 'Testpassword',
                dob: '1990-01-01',
                email: 'test1@example.com',
                account_type: 'reader'
            }

            expect(last_response).to be_redirect
            follow_redirect!

            expect(last_response).to be_ok
            expect(last_request.path).to eq('/')

            #expect(User.where(username: 'testuser')).to exist
        end

        it "doesn't create account when passwords don't match" do
            post '/create-account', {
                username: 'testuser',
                password: 'testpassword',
                confirm_password: 'testpassword_wrong',
                dob: '1990-01-01',
                email: 'test1@example.com',
                account_type: 'reader'
            }

            expect(last_response.body).to include("Ensure that the passwords match")
        end

        it "doesn't create an account when age isn't at least 13" do
            post '/create-account', {
                username: 'testuser',
                password: 'Testpassword',
                confirm_password: 'Testpassword',
                dob: '2020-01-01',
                email: 'test1@example.com',
                account_type: 'reader'
            }

            expect(last_response.body).to include("Invalid Date of Birth")
        end

        it "doesn't create an account when username is already in use" do
            post '/create-account', {
                username: 'testuser',
                password: 'Testpassword',
                confirm_password: 'Testpassword',
                dob: '1990-01-01',
                email: 'test1@example.com',
                account_type: 'reader'
            }
            post '/create-account', {
                username: 'testuser',
                password: 'testpassword2',
                confirm_password: 'testpassword2',
                dob: '1990-01-01',
                email: 'test1@example.com',
                account_type: 'reader'
            }

            expect(last_response.body).to include("Username already taken")
        end

        it "doesn't create an account when e-mail is already in use" do
            post '/create-account', {
                username: 'testuser',
                password: 'Testpassword',
                confirm_password: 'Testpassword',
                dob: '1990-01-01',
                email: 'test1@example.com',
                account_type: 'reader'
            }
            post '/create-account', {
                username: 'testuser2',
                password: 'testpassword2',
                confirm_password: 'testpassword2',
                dob: '1990-01-01',
                email: 'test1@example.com',
                account_type: 'reader'
            }

            expect(last_response.body).to include("Email already in use")
        end

        it "tells you if the chosen password isn't strong enough" do
            post '/create-account', {
                username: 'testuser',
                password: 'testpassword',
                confirm_password: 'testpassword',
                dob: '1990-01-01',
                email: 'test1@example.com',
                account_type: 'reader'
            }

            expect(last_response.body).to include("Password is too weak")
        end
    end
end





