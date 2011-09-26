class SubmissionsController < ApplicationController
  def index
    @submissions = Submission.all
  end
end
