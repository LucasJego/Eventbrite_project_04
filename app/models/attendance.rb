class Attendance < ApplicationRecord

	# Une participation concerne forcément un unique participant
	# belongs_to :user # user au singulier car ne concerne qu'un seul utilisateur
  # -> cette ligne est remplacée par les 2 suivantes
  # pour avoir des administrateurs et des participants
  # (tous les 2 de la classe 'users') plutôt qu'uniquement
  # des users.

  # Une participation concerne forcément un unique administrateur (qui est de la classe 'User')
  belongs_to :administrator, class_name: "User"

  # Une participation concerne forcément un unique participant (qui est de la classe 'User')
  belongs_to :attendant, class_name: "User"

	# Une participation ne peut concerner qu'un unique événement
	belongs_to :event # event au singulier car une participation ne concerne qu'un seul événement




end
