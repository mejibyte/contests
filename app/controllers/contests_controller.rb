class ContestsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @contests = @contests.order("start_date desc")
  end

  def show
    @submissions = @contest.submissions.order("submitted_at desc").limit(10)
  end

  def new
    3.times { @contest.problems.build }
    3.times { @contest.teams.build }
  end

  def create
    if @contest.save
      redirect_to @contest, :notice => "Successfully created contest."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @contest.update_attributes(params[:contest])
      redirect_to @contest, :notice  => "Successfully updated contest."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @contest.destroy
    redirect_to contests_url, :notice => "Successfully destroyed contest."
  end
end
