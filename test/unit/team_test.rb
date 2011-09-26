require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Team.new.valid?
  end
end
