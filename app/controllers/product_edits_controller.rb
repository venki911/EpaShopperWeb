require 'net/http'
require 'json'

class ProductEditsController < ApplicationController

  before_action :set_product_edit, only: [:destroy, :sync]

  def index
    @product_edits = ProductEdit.all
  end

  def create
    p params[:product_edit]

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
=begin
      uri = URI('http://epa-test2.myshopify.com/search?view=json&q=*')
      response = Net::HTTP.get_response(uri)
      jsonResponse = JSON.parse(response.body.force_encoding("UTF-8"), symbolize_names: true)
      p jsonResponse
      puts "=========================================================="
      p jsonResponse[:products]
=end

    uri = URI('https://epa-test2.myshopify.com/admin/orders.json')

    req = Net::HTTP::Get.new(uri)
    req.basic_auth '2e30548629436da9bb5daff1b2a001b5', '3dc0a4fc2c2464041b7c57d2ef5f1c5c'

    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') {|http|
      http.request(req)
    }
    puts res.body
    puts res.code
    puts 'done'

    case res
      when Net::HTTPSuccess then
        puts 'success'
      else
        puts 'failure'
    end

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