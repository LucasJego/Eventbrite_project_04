class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	# Un utilsateur peut participer à plusieurs événements via les participations
	# Un utilisateur peut être administrateur ou participant
	has_many :attendancies, foreign_key: 'attendant_id', class_name: "Attendance"
  has_many :events, through: :attendancies, foreign_key: 'administrator_id', class_name: "Event"
  
  # has_many :attendancies
  # has_many :events, through: :attendancies
  
  # Après la création d'un nouvel user, il doit y avoir un envoi de mail à celui-ci
  after_create :welcome_send

  # Méthode qui appelle le mailer 'AttendantMailer' et lui fait exécuter la méthode 'welcome_email' avec comme entrée l'instance créée (d'où le 'self')
  def welcome_send
  	AttendantMailer.welcome_email(self).deliver_now
  end
end
