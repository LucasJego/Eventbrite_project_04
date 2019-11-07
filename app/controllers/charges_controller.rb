class ChargesController < ApplicationController

	def new
  end

  def create
    puts '-' * 50
    @event = Event.find(params[:id])
    puts '$' * 60

    # Amount in cents
    @amount = @event.price # Définition de @event???

    # Création d'un nouveau client stripe
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    # Création d'un nouveau paiement
    # Récupère l'id du client qui vient d'être créé (lignes au-dessus)
    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: "Paiement de X",
      # On peut changer 'usd' et mettre 'eur' pour payer en euros au lieu de dollars.
      currency: 'usd',
    })

    # S'il y a un problème (carte périmée ou qui ne fonctionne pas par exemple, le programme affiche le flash[:error] et redirige vers la page de paiement)
    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
