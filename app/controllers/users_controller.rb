class UsersController < ApplicationController
  def show
    # GET /users/:id
    @user = User.find(params[:id])
    # => /app/views/users/show.html.erb
  end
  
  def new
    @user = User.new
  end
  
  def create
    #@user = User.new(params[:user])   # <= マスアサイメント脆弱性がある。
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      # redirect_to "/users/#{@user.id}"
      # redirect_to user_path(@user.id)
      # redirect_to user_path(@user)
      redirect_to @user     # => GET /user/#{@user.id} => show
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
