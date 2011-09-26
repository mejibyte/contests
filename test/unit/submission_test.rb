require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Submission.new.valid?
  end
end
