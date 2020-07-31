class SessionsController < ApplicationController
    
    def new
    
    end

    def create
        
        user = User.find_by(email: params[:session] [:email].downcase)
        if user && user.authenticate(params[:session] [:password])
            session[:user_id] = user.id
            flash[:notice] ="logged in successfully"
            redirect_to user
        else
            flash.now[:alert] ="Enter email/password is incorrect"
            render 'new'
            
        end        
    end

    def destroy
        session[:user_id] = nil
        flash[:notice]="Logout sucessfully"
        redirect_to root_path
    end            
end    