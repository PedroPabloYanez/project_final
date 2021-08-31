class ProjectMailer < ApplicationMailer
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.project_mailer.project_create.subject
  #
  def project_create(user)
    @user = user
    @greeting = "Hi, how are you? #{@user.user_name}"
    
    mail(to: @user.email, subject: "Create Project")#@user.email // usuario puntual
  end
end
