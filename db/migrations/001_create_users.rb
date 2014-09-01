require 'securerandom'

Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      String :email, :unique => true
      String :password_digest
      String :name
      Boolean :active, :default => false
      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table(:users)
  end
end