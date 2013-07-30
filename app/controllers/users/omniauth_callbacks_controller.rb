class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      if @user.password
        sign_in @user
        flash[:warning] = "Your current password is #{@user.password}<br>You might want to change it if you want to sign in without facebook.".html_safe
        redirect_to edit_user_registration_path
      else
        sign_in_and_redirect @user, :event => :authentication
      end
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
