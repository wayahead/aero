class AddSoftDeleteToUsers::V00000000000005 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Users) do
      add soft_deleted_at : Time?, index: true
    end
  end

  def rollback
  end
end
