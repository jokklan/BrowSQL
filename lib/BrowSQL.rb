require "brow_sql/version"
require "brow_sql/simple_form"

module BrowSql
  class Engine < Rails::Engine
    # engine_name "BrowSQL"
    isolate_namespace BrowSql
  end
  # Your code goes here...
end
