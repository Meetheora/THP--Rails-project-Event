class AttendancesController < ApplicationController
def new
  @event = Event.find(params[:event_id])
end
def index
  @event = Event.find(params[:event_id])
  redirect_to root_path unless current_user == @event.admin
  @attendances = @event.attendances
end
def create
  @event = Event.find(params[:event_id])
  if @event.is_free?
    redirect_to event_path(@event, success: true), notice: "Inscription confirmée !"
  return
  end

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
    success_url: event_url(@event) + "?success=true",
    cancel_url: root_url + "?canceled=true",
  )
    
  redirect_to session.url, allow_other_host: true
end
end
