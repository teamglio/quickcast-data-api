require_relative '../spec_helper.rb'
include Rack::Test::Methods

  def app
    ApplicationController.new
  end

describe 'ApplicationController' do

  describe "when not found" do

    before do
      authorize "admin", "admin"
    end

    it "should respond with a 404 status" do
      get '/v1/not-found'
      expect(last_response.status).to eq 404
    end

    it "should render errors" do
      get '/v1/not-found'
      expected_response = {
        errors: [
          {
            status: '404',
            title: "Not found"
          }
        ]
      }.to_json
      expect(last_response.body).to eq expected_response
    end
  end

  describe "with valid credentials" do
    it "should return a 200 status" do
      authorize "admin", "admin"
      get '/v1/'
      expect(last_response.status).to eq 200
    end
  end

  describe "with invalid credentials" do
    it "should block the user with a 401" do
      get '/v1/'
      expect(last_response.status).to eq 401
    end
    it "should render 'not authorised'" do
      get 'v1/'
      expected_response = {
        errors: [
          {
            status: '401',
            title: "Not authorised"
          }
        ]
      }.to_json
      expect(last_response.body).to eq expected_response
    end
  end

end
