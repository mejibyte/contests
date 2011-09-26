require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Team.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Team.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Team.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to team_url(assigns(:team))
  end

  def test_edit
    get :edit, :id => Team.first
    assert_template 'edit'
  end

  def test_update_invalid
    Team.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Team.first
    assert_template 'edit'
  end

  def test_update_valid
    Team.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Team.first
    assert_redirected_to team_url(assigns(:team))
  end

  def test_destroy
    team = Team.first
    delete :destroy, :id => team
    assert_redirected_to teams_url
    assert !Team.exists?(team.id)
  end
end
