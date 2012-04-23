class UserController < ApplicationController
  def show
    home_page_requested = !params[:id].present?
    if home_page_requested and not user_signed_in?
      redirect_to new_user_session_path
    else
      if home_page_requested
        @user = current_user
      else
        @user = is_current_user_id?(params[:id]) ? current_user : User.find(params[:id])
      end
      @user_info = @user.user_info
    end
  end

  def upload
    if user_signed_in?
      current_user.user_info.avatar = params[:picture]
      current_user.user_info.save
      unless env["HTTP_ACCEPT"] and env["HTTP_ACCEPT"].include?('application/json')
        response.headers['Content-Type'] = 'text/plain'
      end
      puts response.headers
      render :json => {:file_name => params[:picture].original_filename}
    else
      respond_to do |format|
        format.js {render 'js/sign_up'}
        format.json {render :json => {:login_required => true}}
      end
    end
  end

end
