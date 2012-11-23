class BrowSql::Table < BrowSql::Base
  # self.table_name = "sqlite_master"
  
  self.store_full_sti_class = false
  self.primary_key = :name
  
  attr_accessible :name, :columns
  
  validate :columns_must_be_unique
  
  def columns_must_be_unique
    column_changes.each do |column|
      if columns.map(&:name).include? column.name
        errors.add(:base, "Another column with the same name, already exists")
      end
    end
  end
  
  def self.sti_name #Override
    "table"
  end
  
  def records
    BrowSql::Record.all(self)
  end
  
  def find_record(id)
    records.map do |record|
      return record if record.id == id.to_i
    end
    return nil
  end
  
  def columns
    klass.columns
  end
  
  def column_changes
    @column_changes ||= []
    @column_changes.map{|k,v| v }
  end
  
  def columns=(new_columns)
    @column_changes = new_columns.reject{|k, v| v.current_name == v.name }
  end
  
  private
  
  def self.find_sti_class(type_name)   #Override
    type_name = type_name.classify
    super
  end
  
  def create   #Override
  end
  
  def klass
    name.classify.constantize
  end
  
  def update(attribute_names = @attributes.keys)   #Override
    # Migrations.rename_table self.name, @attributes["name"]
    # attr_list = klass.columns.map { |c| c.name => c.type }
    # raise column_changes.inspect
    Migrations.change_table self.name do |t|
      column_changes.each do |column|
        if column.current_name
          t.send(:rename, column.current_name.to_sym, column.name.to_sym)
        else
          t.send(column.type, column.name.to_sym)
        end
      end
    end
  end
  


end
