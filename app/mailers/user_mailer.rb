class UserMailer < ApplicationMailer
default from: ENV["GMAIL_USERNAME"]

  def welcome_email(user)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user 

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'http://monsite.fr/login' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Bienvenue chez nous !') 
  end

  def attendance_email(attendance)
    @attendance = attendance
    @admin = @attendance.event.admin #variable qui contient le user qui a créé l'event
    @url  = 'http://monsite.fr/login'
    mail(to: @admin.email, subject: 'Nouveau participant inscrit !')
  end
end
