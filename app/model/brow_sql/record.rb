class BrowSql::Record
  # include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  # {
  #   :string      => { :name => "varchar", :limit => 255 },
  #   :text        => { :name => "text" },
  #   :integer     => { :name => "integer" },
  #   :float       => { :name => "float" },
  #   :decimal     => { :name => "decimal" },
  #   :datetime    => { :name => "datetime" },
  #   :timestamp   => { :name => "datetime" },
  #   :time        => { :name => "time" },
  #   :date        => { :name => "date" },
  #   :binary      => { :name => "blob" },
  #   :boolean     => { :name => "boolean" }
  # }
  
  class_attribute :connection, :instance_writer => false
  self.connection = ActiveRecord::Base.connection
  
  def initialize(params = nil, options = {})
    params.each do |attr, value, type|
      attributes.store(attr.to_s, type.type_cast(value))
    end if params
  end
  
  def attributes
    @attributes ||= {}
  end
  
  def persisted?
    false
  end
  
  def destroy(table)
    connection.execute('DELETE FROM "?" WHERE "?"."id"=?', table.name, table.name, id)
  end
  
  class << self
    def all(table)
      connection.execute("SELECT * FROM '#{table.name}'").map do |values|
        self.new(values.each_with_index.map{|(k, v), i| [k, v, table.columns[i]] if table.columns[i] }.reject{|v| v.nil?})
      end
    end
  end
  
  def to_param
    id
  end
  
  def method_missing(method, *args, &block)
    if attributes.keys.include? method.to_s
      attributes.fetch(method.to_s)
    elsif attributes.keys.include? method.to_s.gsub("=", "")
      attributes.store(method.to_s, *args)
    else
      super
    end
  end


end

