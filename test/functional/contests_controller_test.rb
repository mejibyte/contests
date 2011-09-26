require 'test_helper'

class ContestsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Contest.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Contest.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Contest.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to contest_url(assigns(:contest))
  end

  def test_edit
    get :edit, :id => Contest.first
    assert_template 'edit'
  end

  def test_update_invalid
    Contest.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Contest.first
    assert_template 'edit'
  end

  def test_update_valid
    Contest.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Contest.first
    assert_redirected_to contest_url(assigns(:contest))
  end

  def test_destroy
    contest = Contest.first
    delete :destroy, :id => contest
    assert_redirected_to contests_url
    assert !Contest.exists?(contest.id)
  end
end
