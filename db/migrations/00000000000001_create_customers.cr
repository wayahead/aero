class CreateCustomers::V00000000000001 < Avram::Migrator::Migration::V1
  def migrate
    enable_extension "citext"
    enable_extension "pgcrypto"

    create table_for(Customer) do
      primary_key id : UUID
      add_timestamps
      add name : String, index: true, unique: true, case_sensitive: false
      add status : String, default: "activated"
      add description : String?
      add preferences : JSON::Any?
    end
  end

  def rollback
    drop table_for(Customer)
    disable_extension "pgcrypto"
    disable_extension "citext"
  end
end
