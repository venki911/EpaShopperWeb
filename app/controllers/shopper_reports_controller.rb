class ShopperReportsController < ApplicationController

  before_action :set_report, only: [:show, :destroy]
  before_action :require_admin, only: [:destroy]


  # GET INDEX
  #=================================================================================================================
  def index

    if params[:date_filter]
      begin
        target_date = params[:date_filter].to_date.in_time_zone('EST')
        @shopper_reports = ShopperReport.where(:created_at => target_date.beginning_of_day..target_date.end_of_day).order(created_at: :desc)
      rescue
        @shopper_reports = ShopperReport.all.order(created_at: :desc)
      end
    else
      @shopper_reports = ShopperReport.all.order(created_at: :desc)
    end

  end

  # GET SHOW
  #=================================================================================================================
  def show
  end

  # DESTROY
  #=================================================================================================================
  def destroy
    @shopper_report.destroy
    flash[:success] = 'Report successfully deleted'
    redirect_to reports_path
  end

  # POST CREATE
  #=================================================================================================================
  def create

    #p params[:shopper_report]

    if params[:shopper_report]

      begin
        report = ShopperReport.new.convert_from_json(params[:shopper_report])
        report.save
        #Thread.new do
        ReportEmailer.send_report_uploaded_email(report).deliver_now
        #end

        render :json => {success: true} , status: :ok
      rescue => e
        p e.backtrace
        render :json => e , status: :unprocessable_entity
      end

    else
      render :json => {success: false} , status: :unprocessable_entity
    end

  end


  # HELPERS
  #=================================================================================================================

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