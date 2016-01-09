class AssignmentCollectionsController < ApplicationController

  before_action set_assignment_collection, only: [:edit, :update, :destroy]

  # INDEX [HTTP GET]
  #=================================================================================================================
  def index
    @assignment_collections = AssignmentCollection.all
  end

  # EDIT [HTTP GET]
  #=================================================================================================================
  def edit

  end

  def edit_api
    # send info back to angular frontend
  end

  # UPDATE [HTTP POST]
  #=================================================================================================================
  def update
    # save json from angular front end
  end

  # CREATE [HTTP POST]
  #=================================================================================================================
  def create

    if params[:delivery_date]
      target_date = params[:date_filter].to_date.in_time_zone('EST')
      @assignment_collection = AssignmentCollection.new
      @assignment_collection.delivery_date = target_date

      if @assignment_collection.save
        redirect_to shopper_assignments_path(@assignment_collection)
      else
        render action: 'index'
      end

    else
      render action: 'index'
    end

  end

  # DESTROY [HTTP DELETE]
  #=================================================================================================================
  def destroy
    if @assignment_collection.destroy
      flash[:success] = 'Shopper assignments for day deleted..'
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

end