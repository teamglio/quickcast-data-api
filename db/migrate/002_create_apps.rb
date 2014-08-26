Sequel.migration do
  up do
    create_table(:apps) do
      primary_key :id
      String :password_digest
    end
  end

  down do
    drop_table(:apps)
  end
end