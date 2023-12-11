class UserQuery < User::BaseQuery
  # Include this module to add methods for
  # querying and soft deleting records
  include Avram::SoftDelete::Query

  def initialize
    defaults &.only_kept
  end
end
