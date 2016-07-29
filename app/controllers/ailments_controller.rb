class AilmentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /ailments
  # GET /ailments.json
  def index
  end

  # GET /ailments/1
  # GET /ailments/1.json
  def show
  end

  # GET /ailments/new
  def new
  end

  # GET /ailments/1/edit
  def edit
  end

  # POST /ailments
  # POST /ailments.json
  def create
    respond_to do |format|
      if @ailment.save
        format.html { redirect_to @ailment, notice: 'Ailment was successfully created.' }
        format.json { render :show, status: :created, location: @ailment }
      else
        format.html { render :new }
        format.json { render json: @ailment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ailments/1
  # PATCH/PUT /ailments/1.json
  def update
    respond_to do |format|
      if @ailment.update(ailment_params)
        format.html { redirect_to @ailment, notice: 'Ailment was successfully updated.' }
        format.json { render :show, status: :ok, location: @ailment }
      else
        format.html { render :edit }
        format.json { render json: @ailment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ailments/1
  # DELETE /ailments/1.json
  def destroy
    @ailment.destroy
    respond_to do |format|
      format.html { redirect_to ailments_url, notice: 'Ailment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def ailment_params
      params.require(:ailment).permit(:name, :specialty_id)
    end
end
