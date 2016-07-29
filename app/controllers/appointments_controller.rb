class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appointment, only: [:show, :update, :update, :destroy]

  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = Appointment.all
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    @user = User.find(appointment_params['patient_id']) unless @appointment.save
    send_new_appointment_emails if @appointment.persisted?
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    @appointment.update(appointment_params)
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    patient = @appointment.patient
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to user_path(patient), notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:date, :patient_id, :doctor_id)
    end

    def send_new_appointment_emails
      %w(patient doctor).each do |participant|
        AppointmentMailer.send("#{participant}_new_appointment", @appointment).deliver_now
      end
    end
end
