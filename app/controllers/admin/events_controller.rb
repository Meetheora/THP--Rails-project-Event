class Admin::EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
  @event = Event.find(params[:id])
  end

  def update
  @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to admin_event_path(@event), notice: "Événement mis à jour !"
    else
      render :edit
    end
  end

  def destroy
  @event.destroy
  redirect_to admin_events_path, notice: "Événement supprimé"
  end

  private

  def event_params #add validated attribute
    params.require(:event).permit(:title, :start_date, :duration, :description, :price, :location, :photo, :validated)
  end
end
