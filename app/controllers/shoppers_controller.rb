class ShoppersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :require_admin

  # GET LIST SHOPPERS
  #********************************************************************************
  def index

  end

  # GET NEW SHOPPERS
  #********************************************************************************
  def new

  end

  # POST NEW SHOPPERS
  #********************************************************************************
  def create

  end

  # GET EDIT SHOPPERS
  #********************************************************************************
  def edit

  end

  # PATCH EDIT SHOPPERS
  #********************************************************************************
  def update

  end

  #DELETE SHOPPERS
  #********************************************************************************
  def destroy

  end


  private
    def set_user

    end

    def require_admin
      if !is_admin?
        flash[:danger] = 'That action requires admin access'
        redirect_to root_path
      end
    end


end