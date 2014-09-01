namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    require "sequel"
    Sequel.extension :migration
    db = Sequel.connect(ENV.fetch("DATABASE_URL"))
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, "db/migrations")
    end
  end

  desc "Loading test data"
  task :sample do
    require_relative 'models/user.rb'
    puts "Creating sample data"
    User.create(name: 'Test User 1', email: 'test1@test.com', password: 'foo', password_confirmation: 'foo')
    User.create(name: 'Test User 2', email: 'test2@test.com', password: 'foo', password_confirmation: 'foo')
  end
end