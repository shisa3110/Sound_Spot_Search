class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # deviseの機能（ユーザー登録・ログイン認証）が行われる前に、configure_permited_parametersメソッドを実行。
  before_action :configure_permitted_parameters, if: :devise_controller?

  allow_browser versions: :modern

  protected

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :gender ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end
end
