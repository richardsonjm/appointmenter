ready = ->
  $('#appointment_date').datetimepicker
    dateFormat: "yy-mm-dd"
    timeFormat: "h:mm TT"

$(document).ready(ready)
$(document).on('page:load', ready)
