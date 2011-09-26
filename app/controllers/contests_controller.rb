class ContestsController < ApplicationController
  def index
    @contests = Contest.all
  end

  def show
    @contest = Contest.find(params[:id])
    @submissions = @contest.submissions.limit(10)
  end

  def new
    @contest = Contest.new
    3.times { @contest.problems.build }
    3.times { @contest.teams.build }
  end

  def create
    @contest = Contest.new(params[:contest])
    if @contest.save
      redirect_to @contest, :notice => "Successfully created contest."
    else
      render :action => 'new'
    end
  end

  def edit
    @contest = Contest.find(params[:id])
  end

  def update
    @contest = Contest.find(params[:id])
    if @contest.update_attributes(params[:contest])
      redirect_to @contest, :notice  => "Successfully updated contest."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @contest = Contest.find(params[:id])
    @contest.destroy
    redirect_to contests_url, :notice => "Successfully destroyed contest."
  end
end
