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

  def create

    #p params[:shopper_report]

    if params[:shopper_report]

      begin
        report = ShopperReport.new.convert_from_json(params[:shopper_report])
        report.save

        Thread.new do
          ReportEmailer.send_report_uploaded_email(@shopper_report).deliver
        end

        render :json => {success: true} , status: :ok
      rescue => e
        render :json => e , status: :unprocessable_entity
      end

    else
      render :json => {success: false} , status: :unprocessable_entity
    end

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