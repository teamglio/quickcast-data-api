require_relative '../spec_helper.rb'

describe ActivationRequest do
  before do
    @activation_request = ActivationRequest.create(
      user_id: '123',
      activation_code: 'foobar',
    )
  end

  subject { @activation_request }

  describe "when created" do
    it { should respond_to(:user_id) }
    it { should respond_to(:activation_code) }

    it { should be_valid }
  end

  after(:each) do
    DatabaseCleaner.clean
  end

end