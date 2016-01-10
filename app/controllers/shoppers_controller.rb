class ShoppersController < ApplicationController

  before_action :set_shopper, only: [:edit, :update, :destroy]
  before_action :require_admin

  # GET LIST SHOPPERS
  #********************************************************************************
  def index
    @shoppers = Shopper.all
  end

  # GET NEW SHOPPERS
  #********************************************************************************
  def new
    @shopper = Shopper.new
  end

  # POST NEW SHOPPERS
  #********************************************************************************
  def create
    @shopper = Shopper.new(shopper_params)

    if @shopper.save
      flash[:success] = "Shopper created for #{@shopper.username}"
      redirect_to shoppers_path
    else
      render action: 'new'
    end

  end

  # GET EDIT SHOPPERS
  #********************************************************************************
  def edit
  end

  # PATCH EDIT SHOPPERS
  #********************************************************************************
  def update

    if @shopper.update(shopper_params)
      flash[:success] = 'Shopper information updated.'
      redirect_to shoppers_path
    else
      render action: 'edit'
    end

  end

  #DELETE SHOPPERS
  #********************************************************************************
  def destroy
    @shopper.destroy

    if @shopper.id == current_user.id && current_user.admin?
      flash[:danger] = 'Admin account closed.'
      redirect_to root_path
    else
      flash[:danger] = 'Shopper deleted.'
      redirect_to shoppers_path
    end
  end

  private
    def set_shopper
      @shopper = Shopper.find(params[:id])

      if @shopper.nil?
        #raise ActionController::RoutingError.new('Not Found')
        flash[:danger] = 'User not found'
        redirect_to root_path
      end

    end

    def require_admin
      unless is_admin?
        flash[:danger] = 'That action requires admin access'
        redirect_to root_path
      end
    end

    def shopper_params
      params.require(:shopper).permit(:username, :password)
    end

end