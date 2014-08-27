Sequel.migration do
  up do
    create_table(:apps) do
      primary_key :id
      String :client_id
      String :password_digest
      String :user_id
    end
  end

  down do
    drop_table(:apps)
  end
end