class SessionsController < ApplicationController
  def new
    authorize! :read, :session
  end
  
  def create
    authorize! :create, :session
    if Digest::SHA1.hexdigest(params[:session][:password]) == "ab87d24bdc7452e55738deb5f868e1f16dea5ace"
      session[:admin] = true
      redirect_to root_url, :notice => "Welcome in, beautiful person!"
    else
      flash.now[:alert] = "Nope, keep tryin'."
      render "new"
    end
  end
  
  def destroy
    authorize! :destroy, :session
    session[:admin] = nil
    redirect_to root_url, :notice => "Bye bye, beautiful person! See you soon."
  end
end
