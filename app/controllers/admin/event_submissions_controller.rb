class Admin::EventSubmissionsController < ApplicationController
  def index
  @event_to_validate = Event.where(validated:nil)
  end

  def show
  @event = Event.find(params[:id])
  end

  def edit
  @event = Event.find(params[:id])
  redirect_to admin_event_path(@event), notice: "Événement modifié"
  end

  def update
  @event = Event.find(params[:id])
  if @event.update(submission_params)
    validate
  else
    reject
  end
  render :edit
  end

  def validate
  @event = Event.find(params[:id])
  if @event.update(validated: true)
    # Mail à l'auteur
    UserMailer.event_validated(@event).deliver_now
    redirect_to admin_event_submissions_path, notice: "Événement validé et mail envoyé !"
  else
    redirect_to admin_event_submissions_path, alert: "Impossible de valider l'événement."
  end
end

  def reject
  @event = Event.find(params[:id])
  if @event.update(validated: false)
    UserMailer.event_rejected(@event).deliver_now
    redirect_to admin_events_path, notice: "Événement refusé et mail envoyé."
  end
end
  private
  def submission_params
    params.require(:event).permit(:validated)
  end