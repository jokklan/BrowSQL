module BrowSql
  class RecordsController < BrowSqlController
    
    before_filter :find_table
    before_filter :find_record, only: [:show, :edit, :update, :destroy]
    
    def index
      @records = @table.records
    end
  
    def show
    end
  
    def new
      @record = Record.new
    end
  
    def edit
    end
    
    def create
      @record = Record.new(params[:record])

      if @record.save
        redirect_to @record, notice: "#{@record.name} record was successfully created."
      else
        render action: "new"
      end
    end
    
    def update
      if @record.update_attributes(params[:record])
        redirect_to @record, notice: "#{@record.name} record was successfully updated."
      else
        render action: "edit"
      end
    end

    def destroy
      flash[:notice] = "Record was successfully destroyed."
      @record.destroy(@table)

      redirect_to table_records_url(@table)
    end
    
    private
    
    def find_record
      @record = @table.find_record(params[:id])
    end
    
    def find_table
      @table ||= Table.find(params[:table_id])
    end
  
  
  end
end
