class CreateUsers::V00000000000002 < Avram::Migrator::Migration::V1
  def migrate
    enable_extension "citext"
    enable_extension "pgcrypto"

    create table_for(User) do
      primary_key id : UUID
      add_timestamps
      add email : String, index: true, unique: true, case_sensitive: false
      add encrypted_password : String
      add name : String, index: true, unique: true, case_sensitive: false
      add status : String, default: "activated"
      add roles : Array(String), default: ["created"]
      add description : String?
      add preferences : JSON::Any?

      add_belongs_to customer : Customer?, on_delete: :cascade, foreign_key_type: UUID
    end
  end

  def rollback
    drop table_for(User)
    disable_extension "pgcrypto"
    disable_extension "citext"
  end
end
