class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "L'utilisateur a été mis à jour."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "L'utilisateur a été supprimé."
  end

  private

  def user_params
    # On autorise l'admin à modifier ces champs
    params.require(:user).permit(:first_name, :last_name, :description, :email, :admin)
  end
end