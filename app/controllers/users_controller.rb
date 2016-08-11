class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /users
  # GET /users.json
  def index
    @users_and_address = {}
    @users.each do |user|
      @users_and_address[user] = user.has_role?(:doctor) ? Address.business_for(user) : Address.home_for(user)
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET users/1/edit
  def edit
  end

  # PATCH/PUT users/1
  # PATCH/PUT users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE users/1
  # DELETE users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(
        :email, :first_name, :last_name,
        addresses_attributes: [:id, :street, :city, :state, :zip],
        ailment_ids: [], specialty_ids: []
      )
    end
end
