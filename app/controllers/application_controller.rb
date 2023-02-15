class ApplicationController < ActionController::Base

	helper_method :current_student, :logged_in?

	def current_student
		@current_student ||= Student.find(session[:student_id]) if session[:student_id]
	end

	def logged_in?
    	!!current_student
  	end

  	def require_student
	    if !logged_in?
	    	redirect_to login_path, alert: "You must be logged in to perform that action"
	    end
	end

end
