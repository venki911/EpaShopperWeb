class AssignmentCollectionsController < ApplicationController

  before_action :set_assignment_collection, only: [:edit, :edit_api, :update, :destroy]

  # INDEX [HTTP GET]
  #=================================================================================================================
  def index
    @new_assignment_collection = AssignmentCollection.new
    @assignment_collections = AssignmentCollection.all.order(:delivery_date).reverse_order
  end

  # EDIT [HTTP GET]
  #=================================================================================================================
  def edit

  end

  def edit_api
    available_stores = ['Costco', 'Loblaws']
    ordersResponse = OrdersService.get_orders_for_date(@assignment_collection.delivery_date)

    render json: {
        assignment_collection: @assignment_collection.convert_to_json,
        available_shoppers: Shopper.all.collect{|x| x.username},
        available_orders: ordersResponse.orders.collect{|x| x.name},  #['Order #1414', 'Order #2323'],
        available_stores: available_stores
    }.to_json

  end

  # UPDATE [HTTP POST]
  #=================================================================================================================
  def update

    if params.has_key?(:shopper_assignments)
      @assignment_collection.update_shopper_assignments(params[:shopper_assignments])
    end


    if @assignment_collection.save
      render json: {status: 'success'}, status: :ok
    else
      render json: {status: 'failure'}, status: :unprocessable_entity
    end
  end

  # CREATE [HTTP POST]
  #=================================================================================================================
  def create

    target_date = new_assignment_params[:delivery_date].to_date

    if target_date.nil?
      flash[:warning] = 'Delivery date required for making new shopper assignments.'
      redirect_to shopper_assignments_path
      return
    end

    @new_assignment_collection = AssignmentCollection.new(delivery_date: target_date.in_time_zone('EST'))

    if @new_assignment_collection.save
      flash[:success] = "New shopper assignments list for #{@new_assignment_collection.delivery_date} created."
      redirect_to shopper_assignment_path(@new_assignment_collection)
    else
      render 'index'
    end

  end

  # DESTROY [HTTP DELETE]
  #=================================================================================================================
  def destroy
    if @assignment_collection.destroy
      flash[:success] = 'Shopper assignments for day deleted.'
    else
      flash[:danger] = 'Failed to delete shopper assignments for day.'
    end

    redirect_to shopper_assignments_path
  end


  private
    def set_assignment_collection

      @assignment_collection = AssignmentCollection.find(params[:id])

      if @assignment_collection.nil?
        #raise ActionController::RoutingError.new('Not Found')
        flash[:danger] = 'Shopper assignments not found'
        redirect_to root_path
      end

    end

    def new_assignment_params
      params.require(:assignment_collection).permit(:delivery_date)
    end

end