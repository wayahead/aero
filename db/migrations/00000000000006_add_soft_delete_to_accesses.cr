class AddSoftDeleteToAccesses::V00000000000006 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Accesses) do
      add soft_deleted_at : Time?, index: true
    end
  end

  def rollback
  end
end
