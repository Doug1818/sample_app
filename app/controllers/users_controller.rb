class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  before_filter :signed_up_user, only: [:new, :create]

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
	  else
		  render 'new'
	  end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.admin?
      flash[:notice] = "Admins cannot destroy themselves."
      redirect_to users_path
    else
      @user.destroy
      flash[:notice] = "User destroyed"
      redirect_to users_path
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
        flash[:success] = "Profile updated"
        sign_in @user
        redirect_to @user
    else
      render 'edit'
    end
  end

 private
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def signed_up_user
    redirect_to(root_path) if signed_in?
  end
end
