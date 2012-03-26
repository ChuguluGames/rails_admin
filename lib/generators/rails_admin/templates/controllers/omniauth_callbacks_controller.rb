class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google
    @user = User.find_for_open_id(request.env["omniauth.auth"], current_user)

    if @user and @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      flash[:error] = I18n.t "devise.omniauth_callback.failure", :kind => "Google", :reason => I18n.t("devise.failure.inactive")
      redirect_to new_user_session_url
    end
  end
end
