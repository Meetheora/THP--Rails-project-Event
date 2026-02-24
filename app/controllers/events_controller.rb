class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
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
  end
  def edit
  end
  private

  def event_params
    params.require(:event).permit(:title, :start_date, :duration, :description, :price, :location)
  end
end