class ProjectMailer < ApplicationMailer
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.project_mailer.project_create.subject
  #
  def project_create
    @greeting = "Hi, hor are you?"

    mail(to: "pedropablo.yanez@hotmail.com",
        subject: "This is a test"
        )#@user.email // usuario puntual
  end
end
