require_relative '../spec_helper.rb'

describe App do
  before do
    @app = App.create(
      client_id: '123',
      password: 'foo',
      password_confirmation: 'foo',
    )
  end

  subject { @app }

  describe "when created" do
    it { should respond_to(:client_id) }
    it { should respond_to(:password) }
    it { should respond_to(:user) }

    it { should be_valid }
  end

  describe "when client_id is already taken" do
    it do
      app_with_same_client_id = App.new(
        client_id: '123',
        password: 'foo',
        password_confirmation: 'foo'
      )
      expect(app_with_same_client_id).to_not be_valid
    end
  end

  describe "when password is not present" do
    it do
      @app.password = " "
      expect(@app).to_not be_valid
    end
  end

  describe "when password does not match confirmation" do
    it do
      @app.password = "bar"
      expect(@app).to_not be_valid
    end
  end

  after(:each) do
    DatabaseCleaner.clean
  end

end