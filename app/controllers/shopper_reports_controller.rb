class ShopperReportsController < ApplicationController

  before_action :set_report, only: [:show, :destroy]
  before_action :require_admin, only: [:destroy]

  def index
    @shopper_reports = ShopperReport.all
  end

  def show
  end

  def destroy
    @shopper_report.destroy
    flash[:success] = 'Report successfully deleted'
    redirect_to reports_path
  end

  private

    def set_report

      @shopper_report = ShopperReport.find(params[:id])
      if @shopper_report.nil?
        flash[:danger] = 'Report not found'
        redirect_to reports_path
      end

    end

    def require_admin
      if !is_admin?
        flash[:danger] = 'That action requires admin access'
        redirect_to reports_path
      end
    end


end