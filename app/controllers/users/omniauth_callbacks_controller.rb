# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: [:google_oauth2]

  def google_oauth2
    callback_for("google_oauth2")
  end

  def callback_for(provider)
    @omniauth = request.env["omniauth.auth"]
    info = User.find_oauth(@omniauth)
    @user = info[:user]
    if @user.persisted?    # persisted?は保存が完了しているかを評価するメソッド
      sign_in_and_redirect @user, event: :authentication
      # is_navigational_formatはフラッシュメッセージを発行する必要があるかどうかを確認する
      # capitalizeは文字列の先頭を大文字に、それ以外は小文字に変更して返すメソッド
      set_flash_message(:notice, :success, kind: provider.to_s.capitalize) if is_navigational_format?
    else
      @google = info[:google]
      render template: "devise/registrations/new"
    end
  end

  def failure
    redirect_to root_path and return
  end
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
