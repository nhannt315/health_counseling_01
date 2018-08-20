class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    return unless resource.request_doctor?
    resource.type = :Doctor
    resource.save
  end

  private

  def sign_up_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :request_doctor
  end
end
