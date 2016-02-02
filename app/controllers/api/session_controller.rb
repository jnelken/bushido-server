class Api::SessionController < ApplicationController

  def index
    if !current_user
      render json: {}
      return
    end
    @user = current_user
    render "api/users/index"
  end

  
end
