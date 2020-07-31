class UsersController < ApplicationController
    
    before_action :set_user,only: [:edit, :update, :show, :destroy]
    before_action :require_user , only: [:edit, :update ]
    before_action :same_user, only: [:edit,:update,:destroy]
    def new
        @user = User.new
    end 
    
    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] ="Welecome to the Alpha blog, you have successfylly signup"
            redirect_to articles_path
        else
            render 'new'
        end
    end  
    
    def edit
        
    end

    def update
        if @user.update(user_params)
            flash[:notice] = "your account updated"
            redirect_to @user
        else
            render 'edit'
        end        
    end 
    def show
     @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  
    end 
    def index
        @users = User.paginate(page: params[:page], per_page: 5)
   
    end

    def destroy
        @user.destroy
        session[:user_id] = nil if @user == current_user
        flash[:notice]= "Account and article are deleted!"
        redirect_to root_path

    end    
    private
    
    def user_params
       
        params.require(:user).permit( :username, :email, :password)
    
    end 
    def set_user
        @user = User.find(params[:id])
    end 
    
    def same_user
        if current_user != @user && !current_user.admin?
            flash[:notice] = "You can only edit or delete your own profile"
            redirect_to @user
        end    
    end   

end    