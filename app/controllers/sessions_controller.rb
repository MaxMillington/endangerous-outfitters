class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      if current_admin?
        flash[:notice] = "Welcome back admin"
        redirect_to admin_dashboard_path
      else
        flash[:notice] = "Successful login!"
        redirect_to root_path
      end
    else
      flash[:error] = "Invalid login credentials"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end