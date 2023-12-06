class CreateAccesses::V00000000000003 < Avram::Migrator::Migration::V1
  def migrate
    enable_extension "citext"
    enable_extension "pgcrypto"

    create table_for(Access) do
      primary_key id : UUID
      add_timestamps
      add app : String, index: true, case_sensitive: false
      add key : String, unique: true, case_sensitive: false
      add secret : String, unique: true, case_sensitive: false
      add status : String, default: "activated"
      add preferences : JSON::Any?

      add_belongs_to user : User, on_delete: :cascade, foreign_key_type: UUID
    end
  end

  def rollback
    drop table_for(Access)
    disable_extension "pgcrypto"
    disable_extension "citext"
  end
end
