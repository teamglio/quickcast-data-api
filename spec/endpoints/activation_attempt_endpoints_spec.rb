require_relative '../spec_helper.rb'
include Rack::Test::Methods

describe 'ActivationAttemptEndpoints' do

  before do
    def app
      ActivationAttemptEndpoints.new
    end
    ActivationAttemptEndpoints.show_exceptions = false
    ActivationAttemptEndpoints.raise_errors = true
    authorize "admin", "admin"
    @user = User.create(name: 'Test User 1', email: 'user_1@test.com', password: 'foobar', password_confirmation: 'foobar')
    @activation_code = @user.request_activation
  end

  describe 'POST /activationAttempts' do

    describe "with invalid params" do

      it "should return a 400 status code" do
        post "/v1/activationAttempts"
        expect(last_response.status).to eq 400
      end

      it "should render an error" do
        post "/v1/activationAttempts"
        response = JSON.parse(last_response.body)
        expect(response).to include 'errors'
      end

    end

    describe "with valid params" do

      describe "if activation code does not match" do

        it "should return a 400 status code" do
          post "/v1/activationAttempts", {:user_id => @user.id, :activation_code => 'non-matching-code'}
          expect(last_response.status).to eq 400
        end

        it "should render an error" do
          post "/v1/activationAttempts", {:user_id => @user.id, :activation_code => 'non-matching-code'}
          response = JSON.parse(last_response.body)
          expect(response).to include 'errors'
        end

      end

      describe "if activation code matches" do

        it "should return a 200 status code" do
          post "/v1/activationAttempts", {:user_id => @user.id, :activation_code => @activation_code}
          expect(last_response.status).to eq 200
        end

        it "should render the user with active set to true" do
          post "/v1/activationAttempts", {:user_id => @user.id, :activation_code => @activation_code}
          response = JSON.parse(last_response.body)
          expect(response['users'].first['active']).to eq true
        end

      end

    end

  end

  after do
    DatabaseCleaner.clean
  end

end
