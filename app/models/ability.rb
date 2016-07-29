class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    return unless user.persisted?

    if user.has_role? :admin
      can :manage, Ailment
      can :manage, Appointment
      can :manage, DoctorsSpecialty
      can :manage, PatientsAilment
      can :manage, Specialty
      can :manage, User
    end

    if user.has_role? :doctor
      can [:show, :update], Appointment, doctor_id: user.id
      can :create, DoctorsSpecialty
      can :destroy, DoctorsSpecialty, doctor_id: user.id
    end

    can :show, User, id: user.id
    can :show, User, roles: { name: 'doctor' }
    can :index, User, roles: { name: 'doctor' }

    can :create, Appointment
    can [:show, :update, :destroy], Appointment, patient_id: user.id

    can :read, Ailment
    can :read, Specialty

    can :create, PatientsAilment
    can :destroy, PatientsAilment, patient_id: user.id
  end
end
