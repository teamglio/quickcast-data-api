require_relative '../spec_helper.rb'

describe User do
  before do
    @user = User.create(
      email: 'user@test.com',
      password: 'foo',
      password_confirmation: 'foo',
      name: 'Tester'
    )
  end

  subject { @user }

  describe "when created" do
    it { should respond_to(:email) }
    it { should respond_to(:password) }
    it { should respond_to(:name) }
    it { should respond_to(:active) }
    it { should respond_to(:apps) }

    it { should be_valid }
  end

  describe "when email is not present" do
   before { @user.email = " " }
    it { should_not be_valid }
  end

   describe "when email is invalid" do
    it do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email is valid" do
    it do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email is already taken" do
    it do
      user_with_same_email_address = User.new(
        email: 'user@test.com',
        password: 'foo',
        password_confirmation: 'foo',
        name: 'Tester'
      )
      expect(user_with_same_email_address).to_not be_valid
    end
  end

  describe "when password is not present" do
    it do
      @user.password = " "
      @user.password_confirmation = " "
      expect(@user).to_not be_valid
    end
  end

  describe "when password does not match confirmation" do
    it do
      @user.password = "bar"
      expect(@user).to_not be_valid
    end  end

  after(:each) do
    DatabaseCleaner.clean
  end

end