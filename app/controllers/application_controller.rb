class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # deviseの機能（ユーザー登録・ログイン認証）が行われる前に、configure_permited_parametersメソッドを実行。
  before_action :configure_permitted_parameters, if: :devise_controller?

  allow_browser versions: :modern

  # ここ以下のメソッドは、呼び出された他のコントローラからも参照できる
  protected

  protected
  def configure_permitted_parameters
    # ユーザー登録時にnameのストロングパラメータを追加（サインアップ時にname,genderを入力する場合は追記）
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :gender])
    # ユーザー編集時にnameとprofileのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
