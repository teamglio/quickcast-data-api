require_relative '../spec_helper.rb'
include Rack::Test::Methods

describe 'UserEndpoints' do

  before do
    def app
      UserEndpoints.new
    end
    UserEndpoints.show_exceptions = false
    UserEndpoints.raise_errors = true
    authorize 'admin', 'admin'
    @user_1 = User.create(name: 'Test User 1', email: 'user_1@test.com', password: 'foobar', password_confirmation: 'foobar')
    @user_2 = User.create(name: 'Test User 2', email: 'user_2@test.com', password: 'foobar', password_confirmation: 'foobar')
    @users = User.all
  end

  describe 'GET /users' do

    it 'should return a 200 status' do
      get '/v1/users'
      expect(last_response.status).to eq 200
    end

    it 'should render all users' do
      get '/v1/users'
      response = JSON.parse(last_response.body)
      response['users'].each do |user|
        expect(@users.collect { |u| u.id.to_s }.include?(user['id'])).to eq true
      end
    end

    it 'should render the the user id and email' do
      get "/v1/users/#{@user_1.id}"
      response = JSON.parse(last_response.body)
      expect(response['users'].first).to include 'id'
      expect(response['users'].first).to include 'name'
      expect(response['users'].first).to include 'email'
    end

  end

  describe 'GET /users/user_id' do

    describe 'if user is found' do

      it 'should return a 200 status' do
        get '/v1/users'
        expect(last_response.status).to eq 200
      end

      it 'should render the user' do
        get "/v1/users/#{@user_1.id}"
        response = JSON.parse(last_response.body)
        expect(response['users'].first).to include 'id'
        expect(response['users'].first).to include 'name'
        expect(response['users'].first).to include 'email'
      end

    end

    describe 'if user is not found' do

      it 'should return a 200 status' do
        get '/v1/users'
        expect(last_response.status).to eq 200
      end

      it 'should render no users' do
        get '/v1/users/123'
        response = JSON.parse(last_response.body)
        expect(response['users']).to be_empty
      end

    end

  end

  describe 'POST /users' do

    describe 'with valid params' do

      it 'should return a 201 status' do
        post '/v1/users', {:name => 'Test User 3', :email =>'user_3@test.com', :password => 'foobar', :password_confirmation => 'foobar'}
        expect(last_response.status).to eq 201
      end

      it 'should render an the created user' do
        post '/v1/users', {:name => 'Test User 3', :email =>'user_3@test.com', :password => 'foobar', :password_confirmation => 'foobar'}
        response = JSON.parse(last_response.body)
        expect(response['users'].first).to include 'id'
        expect(response['users'].first).to include 'name'
        expect(response['users'].first).to include 'email'
      end

    end

    describe 'with invalid params' do

      it 'should return a 400 status' do
        post '/v1/users'
        expect(last_response.status).to eq 400
      end

      it 'should render an error' do
        post '/v1/users'
        response = JSON.parse(last_response.body)
        expect(response).to include 'errors'
      end

    end

  end

  describe 'PATCH /users' do

  end

  describe 'DESTROY /users' do

  end

  after do
    DatabaseCleaner.clean
  end

end
