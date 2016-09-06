# Appointmenter

This is a tool to schedule doctor's appointments.

This tool keeps track of the following attributes of patients and doctors:
1. Keeps track of a patient's ailment and a doctor's specialty.
2. Appointments for treatment match doctors to patients
   ensuring that:
   a. the doctor's address is within 10 miles of the patient's
   b. the doctor's specialty is appropriate for the patient's injury
   c. these appointments are scheduled at least 3 days in the future.
   d. an email is sent to both the doctor and the patient when the appointment
      is scheduled with the appointment details including:
      1. doctor's name and address
      2. patient's name
      3. time and date of appointment

Application uses foreman and dotenv-rails to manage configuration variables.
Before launch copy .env.sample to .env and supply the required definitions.


To launch type the following command:

```
foreman start -f Procfile.development
```
