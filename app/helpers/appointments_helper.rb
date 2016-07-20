module AppointmentsHelper
  def human_readable_date(datetime)
    datetime.strftime("%Y-%m-%d %l:%M %p")
  end
end
