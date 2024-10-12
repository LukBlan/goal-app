class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:session][:username], params[:session][:password])

    if user
      login(user)
      redirect_to homes_path
    else
      redirect_to new_session_url
    end
  end
end
