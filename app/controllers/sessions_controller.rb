class SessionsController < ApplicationController

  def new
  end

  def create
    student = Student.find_by(studemail: params[:session][:studemail].downcase)
    
    if student && student.authenticate(params[:session][:password])
      session[:student_id] = student.id
      redirect_to student, notice: 'Logged in successfully'
    else
      flash.now[:alert] = "There was something wrong with your login details"
      render 'new'
    end
  end

  def destroy
    session[:student_id] = nil
    redirect_to root_path, notice: 'Logged out'
  end

end