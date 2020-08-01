class CategoriesController < ApplicationController

    # before_action :set_category, only: [:show] 
   
    def new
        @category=Category.new
    end    
    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:notice] = "Category was successfully created"
            redirect_to @category 
        else
            render 'new'
        end       
    end 
    

    def index
    
    end

    def show
        @category = Category.find(params[:id])
    end 
     
    private

    def category_params
        params.require(:category).permit(:name)
    end

    # def set_category
        
    # end
end
