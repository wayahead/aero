class AddSoftDeleteToCustomers::V00000000000004 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Customers) do
      add soft_deleted_at : Time?, index: true
    end
  end

  def rollback
  end
end
