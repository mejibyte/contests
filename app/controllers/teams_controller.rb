class TeamsController < ApplicationController
  before_filter :load_contest
  before_filter :redirect_if_contest_finished
  load_and_authorize_resource
  
  def new
  end
  
  def create
    @team = Team.find_by_username(params[:team][:username]) || Team.create(params[:team])
    if @team.valid?
      @contest.add_team!(@team)
      redirect_to @contest, :notice => "Team added!"
    else
      render :new
    end
  end
  
  protected
  
  def load_contest
    @contest = Contest.find(params[:contest_id])
    authorize! :read, @contest
  end
  
  def redirect_if_contest_finished
    if @contest.finished?
      redirect_to @contest, :alert => "This contest has finished. You can't add new teams anymore!"
    end
  end
  
end
