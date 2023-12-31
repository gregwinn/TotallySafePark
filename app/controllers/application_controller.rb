class ApplicationController < ActionController::Base
	rescue_from CanCan::AccessDenied do |exception|
		respond_to do |format|
			format.json { render json: { "error": "Ah, ah, ah! You didn't say the magic word!" }, status: :forbidden }
			format.html { redirect_to root_path, alert: exception.message }
		end
	end
end
