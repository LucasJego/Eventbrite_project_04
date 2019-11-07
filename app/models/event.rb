class Event < ApplicationRecord

	# Un événement peut avoir plusieurs participations
	has_many :attendancies
	# Un événement peut avoir plusieurs utilisateurs via les participations
	#has_many :users, through: :attendancies # Les 2 au pluriel!
  
  # Un événement peut avoir plusieurs participants (qui sont de la classe 'User') via les participations
  has_many :attendants, through: :attendancies, foreign_key: 'attendant_id', class_name: "User"

  # Un événement appartient à un unique administrateur qui est de la classe 'User'
  belongs_to :administrator, foreign_key: 'administrator_id', class_name: "User"


  # ----------------------------------------
	# Validations
  
  # Méthode qui regarde si la date de l'événement n'est pas dans le passé
  def is_past?
  	errors.add(:start_date, message: "La date de l'événement ne doit pas être passée !") if start_date < Time.now
  end

  #def is_multiple_of_5(duration)
  #  if duration % 5 == 0
  #  end
  #end

  # Méthode qui affiche un message d'erreur si la durée de l'événement n'est pas un multiple de 5
  def is_multiple_of_5?
  	errors.add(:duration, message: "La durée doit être un multiple de 5.") unless
  	self.duration % 5 == 0
  end


  # La présence de la date de départ, de la durée, du titre, de la description, du prix et du lieu est obligatoire
  validates :start_date, :duration, :title, :description, :price, :location, presence: true
  

  #validates : date: {after: Time.now}
  
  # La durée en min doit obligatoirement être un multiple de 5
  # -> on fait appel à la méthode 'is_multiple_of_5' (/!\ ne pas oublier le '?')
  # et doit obligatoirement être > 0.
  validates :duration, numericality: {greater_than: 0}
  # /!\ si on fait appel à une méthode (ici 'is_multiple_of_5?')
  # on doit écrire 'validate', SANS le 's'
  validate :is_multiple_of_5? # Pas besoin d'écrire que ça concerne 'duration', on l'a déjà mis dans la méthode 'is_multiple_of_5?'
  
  # Le titre doit faire au minimum 5 caractères et au maximum 140
  # Si ce n'est pas le cas, un message d'erreur est affiché
  validates :title, length: { in: 5..140, too_short: 'Le titre est trop court.', too_long: 'Le titre est trop long.' }
  
  # La description doit faire au min 20 caractères et au max 1000
  # Sinon, un message d'erreur apparaît
  validates :description, length: { in: 20..1000, too_short: 'La description est trop courte.', too_long: 'La description est trop longue.' }
  
  # Le prix doit être compris entre 1 et 1000
  validates :price, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 1000}
end
