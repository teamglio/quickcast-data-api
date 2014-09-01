Sequel.migration do
  up do
    create_table(:activation_requests) do
      primary_key :id
      foreign_key :user_id
      String :activation_code
      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table(:activation_requests)
  end
end