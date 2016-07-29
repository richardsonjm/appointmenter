class SpecialtiesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /specialties
  # GET /specialties.json
  def index
  end

  # GET /specialties/1
  # GET /specialties/1.json
  def show
  end

  # GET /specialties/new
  def new
  end

  # GET /specialties/1/edit
  def edit
  end

  # POST /specialties
  # POST /specialties.json
  def create
    @specialty = Specialty.new(specialty_params)

    respond_to do |format|
      if @specialty.save
        format.html { redirect_to @specialty, notice: 'Specialty was successfully created.' }
        format.json { render :show, status: :created, location: @specialty }
      else
        format.html { render :new }
        format.json { render json: @specialty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /specialties/1
  # PATCH/PUT /specialties/1.json
  def update
    respond_to do |format|
      if @specialty.update(specialty_params)
        format.html { redirect_to @specialty, notice: 'Specialty was successfully updated.' }
        format.json { render :show, status: :ok, location: @specialty }
      else
        format.html { render :edit }
        format.json { render json: @specialty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /specialties/1
  # DELETE /specialties/1.json
  def destroy
    @specialty.destroy
    respond_to do |format|
      format.html { redirect_to specialties_url, notice: 'Specialty was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def specialty_params
      params.require(:specialty).permit(:name)
    end
end
