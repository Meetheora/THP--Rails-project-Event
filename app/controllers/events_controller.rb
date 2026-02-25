class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authorize_admin!, only: [:edit, :update, :destroy]
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.admin = current_user
    if @event.save
      redirect_to root_path, notice: "Événement créé !"
    else
      render :new
    end
  end
  def show
    @event = Event.find(params[:id])
    if params[:success] == "true"
      # On vérifie qu'il n'est pas déjà inscrit pour éviter les doublons si on recharge la page
      unless @event.participants.include?(current_user)
        Attendance.create!(
          user: current_user, 
          event: @event, 
          stripe_customer_id: "cus_id_temporaire" # (ou récupéré dynamiquement via Stripe)
        )
      end
      # On redirige proprement vers la page de l'événement pour nettoyer l'URL (enlever le ?success=true)
      redirect_to event_path(@event), notice: "Paiement réussi ! Tu participes désormais à cet événement."
    end
  end
  def edit
  @event = Event.find(params[:id])
  end
  def update
  @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: "Événement mis à jour !"
    else
      render :edit
    end
  end
  def destroy
  @event.destroy
  redirect_to root_path, notice: "Événement supprimé"
  end
  private

  def event_params
    params.require(:event).permit(:title, :start_date, :duration, :description, :price, :location)
  end

  def set_event
  @event = Event.find(params[:id])
  end

  def authorize_admin!
    unless current_user == @event.admin
      redirect_to root_path, alert: "Tu n'es pas l'organisateur de cet évènement."
    end
  end
end