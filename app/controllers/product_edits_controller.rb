require 'net/http'
require 'json'

class ProductEditsController < ApplicationController

  before_action :set_product_edit, only: [:destroy, :sync, :upload_image]

  # INDEX [HTTP GET]
  #=================================================================================================================
  def index
    @product_edits = ProductEdit.all
  end

  # CREATE PRODUCT EDIT [HTTP POST]
  #=================================================================================================================
  def create
    #p params[:product_edit]

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

  # UPLOAD IMAGE [HTTP PUT]
  #=================================================================================================================
  def upload_image

    if params[:image]

      begin
        @product_edit.image = params[:image]
      rescue => e
        p e.backtrace
        render :json => e, status: :unprocessable_entity
      end

      if @product_edit.save
        render :json => {success: true}, status: :ok
      else
        render :json => {success: false}, status: :unprocessable_entity
      end

    else
      render :json => {success: false}, status: :unprocessable_entity
    end


  end


  # DELETE
  #=================================================================================================================
  def destroy
    @product_edit.destroy
    flash[:success] = 'Product update request successfully deleted'
    redirect_to product_edits_path
  end

  # SYNC WITH SHOPIFY [HTTP POST]
  #=================================================================================================================
  def sync
    response = ProductEditsService.sync_product_edit(@product_edit)

    if response.success?
      @product_edit.updated = !@product_edit.updated
      @product_edit.save
    else
      flash[:danger] = response.operation_error
    end

    redirect_to product_edits_path
  end

  # PRIVATE HELPERS
  #=================================================================================================================
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