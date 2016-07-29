class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /appointments
  # GET /appointments.json
  def index
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
