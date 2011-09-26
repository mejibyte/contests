class SubmissionsController < ApplicationController
  def index
    @contest = Contest.find(params[:contest_id])
    @submissions = @contest.submissions.order("submitted_at desc").all
  end
end
