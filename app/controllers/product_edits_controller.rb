class ProductEditsController < ApplicationController

  before_action :set_product_edit, only: [:destroy, :sync]

  def index
    @product_edits = ProductEdit.all
  end

  def create
    #p params[:shopper_report]

    if params[:product_edit]

      begin
        report = ProductEdit.new.convert_from_json(params[:product_edit])
        report.save

        render :json => {success: true} , status: :ok
      rescue => e
        p e.backtrace
        render :json => e , status: :unprocessable_entity
      end

    else
      render :json => {success: false} , status: :unprocessable_entity
    end
  end

  def destroy
    @product_edit.destroy
    flash[:success] = 'Product edit request successfully deleted'
    redirect_to product_edits_path
  end

  def sync
    redirect_to product_edits_path
  end

  private
  def set_product_edit
    @product_edit = ProductEdit.find(params[:id])

    if @product_edit.nil?
      #raise ActionController::RoutingError.new('Not Found')
      flash[:danger] = 'Product edit not found'
      redirect_to root_path
    end

  end
end