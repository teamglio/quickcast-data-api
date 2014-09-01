Sequel.migration do
  up do
    create_table(:apps) do
      primary_key :id
      foreign_key :user_id
      String :client_id
      String :password_digest
      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table(:apps)
  end
end