class Admin::EventSubmissionsController < Admin::BaseController
  def index
  @event_to_validate = Event.where(validated:false)
  end

  def show
  @event = Event.find(params[:id])
  end

  def edit
  @event = Event.find(params[:id])
  end

  def update
  @event = Event.find(params[:id])

    if params[:commit] == "Valider"
      @event.update(validated: true)
      UserMailer.event_validated(@event).deliver_now
      redirect_to admin_event_submissions_path, notice: "Événement validé"

    elsif params[:commit] == "Refuser"
      @event.update(validated: false)
      UserMailer.event_rejected(@event).deliver_now
      redirect_to admin_event_submissions_path, notice: "Événement refusé"

    else
      redirect_to admin_event_submissions_path
    end
  end
end