require_relative '../spec_helper.rb'
include Rack::Test::Methods

def app
  UsersController.new
end

describe 'UsersController' do

  before do
    authorize "admin", "admin"
    @user_1 = User.create(name: 'Test User 1', email: 'user_1@test.com', password: 'foobar', password_confirmation: 'foobar')
    @user_2 = User.create(name: 'Test User 2', email: 'user_2@test.com', password: 'foobar', password_confirmation: 'foobar')
    @users = User.all
  end

  describe 'GET /users' do

    it "should render all users" do
      get '/v1/users'
      response = JSON.parse(last_response.body)
      response['users'].each do |user|
        expect(@users.collect { |u| u.id.to_s }.include?(user['id'])).to eq true
      end
    end

    it "should expose the user's id and email" do
      get "/v1/users/#{@user_1.id}"
      response = JSON.parse(last_response.body)
      expect(response['users'].first).to include "id"
      expect(response['users'].first).to include 'name'
      expect(response['users'].first).to include "email"
    end

  end

  describe 'GET /users/user_id' do

    it "should render a specific user" do
      get "/v1/users/#{@user_1.id}"
      response = JSON.parse(last_response.body)
      expect(response['users'].first['id']).to eq @user_1.id.to_s
    end

    it "should expose the user's id and email" do
      get "/v1/users/#{@user_1.id}"
      response = JSON.parse(last_response.body)
      expect(response['users'].first).to include 'id'
      expect(response['users'].first).to include 'name'
      expect(response['users'].first).to include 'email'
    end

  end

  describe 'POST /users' do

    describe "with valid params" do

      it "should return a 201 status code" do
        post "/v1/users", {:name => 'Test User 3', :email =>'user_3@test.com', :password => 'foobar', :password_confirmation => 'foobar'}
        expect(last_response.status).to eq 201
      end

      it "should render an the created user" do
        post "/v1/users", {:name => 'Test User 3', :email =>'user_3@test.com', :password => 'foobar', :password_confirmation => 'foobar'}
        response = JSON.parse(last_response.body)
        expect(response['users'].first).to include 'id'
        expect(response['users'].first).to include 'name'
        expect(response['users'].first).to include 'email'
      end

    end

    describe "with invalid params" do

      it "should return a 400 status code" do
        post "/v1/users"
        expect(last_response.status).to eq 400
      end

      it "should render an error" do
        post "/v1/users"
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
    User.db[:users].delete
  end

end
