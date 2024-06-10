class AdminsBackoffice::AdminsController < AdminsBackofficeController
  before_action :set_admin, only: %i[ edit update destroy ]
  before_action :verify_password, only: %i[ update ]

  def index
    @admins = Admin.all.page(params[:page])
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params_admin)
    if @admin.save
      redirect_to admins_backoffice_admins_path, notice: "Administrator created with success!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @admin.update(params_admin)
      redirect_to admins_backoffice_admins_path, notice: "Administrator updated with success!"
    else
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      redirect_to admins_backoffice_admins_path, notice: "Administrator removed with success!"
    else
      render :index
    end
  end

  private

  def params_admin
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def verify_password
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].extract!(:password, :password_confirmation)
    end
  end
end
