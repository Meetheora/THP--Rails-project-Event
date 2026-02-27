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
    @user  = attendance.user      # participant
    @event = attendance.event     # event
    @admin = attendance.event.admin
    @url   = 'http://monsite.fr/login'

    mail(to: @admin.email, subject: 'Nouveau participant inscrit !')
  end

    # Mail de validation d'événement
  def event_validated(event)
    @event = event
    @user = @event.admin
    mail(
      to: @user.email,
      subject: "Votre événement a été validé ! 🎉"
    )
  end

  # Mail de refus d'événement
  def event_rejected(event)
    @event = event
    @user = @event.admin
    mail(
      to: @user.email,
      subject: "Votre événement n'a pas été validé ❌"
    )
  end
end
