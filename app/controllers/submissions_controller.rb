class SubmissionsController < ApplicationController
  load_and_authorize_resource  
  def index
    @contest = Contest.find(params[:contest_id])
    @submissions = @contest.submissions.order("submitted_at desc").all
  end
end
