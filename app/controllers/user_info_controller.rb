class UserInfoController < ApplicationController

  load_and_authorize_resource

  def edit
    @user_info = UserInfo.find(params[:id])
  end

  def update
    @user_info = UserInfo.find(params[:id])
    if @user_info.update_attributes!(params[:user_info])
      redirect_to :controller => :user, :action => :show, :id => @user_info.user_id
    else
      render action: "edit"
    end
  end
end
