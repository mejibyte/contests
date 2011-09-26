require 'test_helper'

class ContestTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Contest.new.valid?
  end
end
