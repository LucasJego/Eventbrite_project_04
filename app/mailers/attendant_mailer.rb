class AttendantMailer < ApplicationMailer

	# Adresse par défaut depuis laquelle seront envoyés les mails
	default from: 'no-reply01@monsite.fr'

	def welcome_email(user)
		# On récupère l'instance user pour ensuite pouvoir la passer à la view en @administrator
		@administrator = user

		# On définit un variable @url qu'on utilisera dans la view d'email
		@url = 'http://monsite.fr/login'

		# C'est l'appel suivant à mail() qui permet d'envoyer l'email en définissant le destinataire et le sujet
		# ? mail serait une fonction dédiée pour envoyer des mails ?
		mail(to: @administrator.email, subject: 'Bienvenue chez nous !')
	end
end
