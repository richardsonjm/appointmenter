# Specialties
orthopedics = FactoryGirl.create(:specialty, name: "Orthopedics")
opthamology = FactoryGirl.create(:specialty, name: "Opthamology")
cardiology = FactoryGirl.create(:specialty, name: "Cardiology")

# Ailments
broken_bones = FactoryGirl.create(:ailment, name: "broken bones", specialty: orthopedics)
eye_trouble = FactoryGirl.create(:ailment, name: "eye trouble", specialty: opthamology)
heart_disease = FactoryGirl.create(:ailment, name: "heart disease", specialty: cardiology)

# Patients
[broken_bones, eye_trouble, heart_disease].each do |ailment|
  FactoryGirl.create(:patient, ailments: [ailment])
end

# Doctors
[orthopedics, opthamology, cardiology].each do |specialty|
  FactoryGirl.create(:doctor, specialties: [specialty])
end
