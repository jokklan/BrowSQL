class BrowSql::Base < ActiveRecord::Base
  self.table_name = "sqlite_master"
  # self.abstract_class = true
  
  class Migrations < ActiveRecord::Migration
  end
  
  private
  
  
end
