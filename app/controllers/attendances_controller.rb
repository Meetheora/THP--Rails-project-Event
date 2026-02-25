class AttendancesController < ApplicationController
def new
  @event = Event.find(params[:event_id])
end
def index
end
def create
  @event = Event.find(params[:event_id])
  
  session = Stripe::Checkout::Session.create(
    payment_method_types: ['card'],
    line_items: [{
      price_data: {
        currency: 'eur',
        product_data: {
          name: @event.title,
        },
        unit_amount: @event.price * 100, # Stripe prend le montant en centimes (hors sources)
      },
      quantity: 1,
    }],
    mode: 'payment',
    # Les URL de redirection après le paiement :
    success_url: root_url + "?success=true",
    cancel_url: root_url + "?canceled=true",
  )
    
  redirect_to session.url, allow_other_host: true
end
end
