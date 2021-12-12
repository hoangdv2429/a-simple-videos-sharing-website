class UsersController < ApplicationController
  def show
  end
end

def destroy
  current_user.Video.find(params[id]).destroy
  redirect_to root_path
end