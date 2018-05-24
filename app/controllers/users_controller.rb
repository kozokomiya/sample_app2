class UsersController < ApplicationController
  # edit, updateアクションを実行する前にlogged_in_userメソッドを実行する
  # シンボルによるメソッド参照
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    # GET /users/:id
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    # => /app/views/users/show.html.erb
  end
  
  def new
    @user = User.new
  end
  
  def create
    #@user = User.new(params[:user])   # <= マスアサイメント脆弱性がある。
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
#      log_in @user
#      flash[:success] = "Welcome to the Sample App!"
#      # redirect_to "/users/#{@user.id}"
#      # redirect_to user_path(@user.id)
#      # redirect_to user_path(@user)
#      redirect_to @user     # => GET /user/#{@user.id} => show
    else
      render 'new'
    end
  end

  # GET /users/:id/edit
  # params[:id] => :id
  def edit
    @user = User.find(params[:id])
    # app/views/users/edit.html.erb
  end
  
  #PATCH /users/:id
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      # Failure
      # => @user.errors.full_messages()
      render 'edit'
    end
  end

  # DELETE /users/:id
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    # before アクション
    
    # 正しいユーザーかどうか確認
    def correct_user
      # GET /users/:id/edit
      # PATCH /users/:id
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end    
end
