module BrowSql
  class TablesController < BrowSqlController
    
    before_filter :find_table, only: [:show, :edit, :update, :destroy]
  
    def index
      @tables = Table.all
    end
  
    def show
    end
  
    def new
      @table = Table.new
    end
  
    def edit
    end
    
    def create
      @table = Table.new(params[:table])

      if @table.save
        redirect_to @table, notice: "#{@table.name} table was successfully created."
      else
        render action: "new"
      end
    end
    
    def update
      if @table.update_attributes(params[:table])
        redirect_to @table, notice: "#{@table.name} table was successfully updated."
      else
        render action: "edit"
      end
    end

    def destroy
      flash[:notice] = "#{@table.name} table was successfully destroyed."
      @table.destroy

      redirect_to tables_url
    end
    
    private
    
    def find_table
      @table ||= Table.find(params[:id])
    end
  
  
  end
end
