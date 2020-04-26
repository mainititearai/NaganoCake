class ApplicationController < ActionController::Base


	def after_sign_in_path_for(resource)
    	case resource
    	when Admin
     		admin_root_path
    	when Member
     		root_path(resource)
    	end
  	end

   def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else
      new_member_session_path
    end
  end

  def after_inactive_sign_up_path_for(resource)
      home_wait_path
  end

  #アカウント編集後のリダイレクト先
  def after_update_path_for(resource)
      home_wait_path
  end

  	before_action :configure_permitted_parameters, if: :devise_controller?

  	protected

    def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name,:first_name,:last_name_kana,:first_name_kana,:address,:postcode,:phone_number,:valid_status])
    #sign_upの際にデフォルト項目より追加したカラムのデータ操作を許可
	end

end
