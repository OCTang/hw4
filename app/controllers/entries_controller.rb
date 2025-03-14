class EntriesController < ApplicationController

  def new
    @user = User.find_by({ "id" => session["user_id"] })
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @entry = Entry.new
      @entry.user_id = session["user_id"]
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry["place_id"] = params["place_id"]
      @entry.save
    else
      flash["notice"] = "Login first."
    end
    redirect_to "/places/#{@entry["place_id"]}"
  end

  def show
    @entry = Entry.find_by(id: params[:id])
    if @entry.nil? || @entry.user_id != session["user_id"]
      flash[:alert] = "You do not have permission to view this entry."
      redirect_to entries_path
    end
  end

end
