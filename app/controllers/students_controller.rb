class StudentsController<ApplicationController
	before_action :set_student, only: [:show, :edit, :update, :destroy]
	before_action :require_student, only: [:edit, :update]
  	before_action :require_same_student, only: [:edit, :update, :destroy]

	def show
		@articles = @student.articles.paginate(page: params[:page], per_page: 3)
	end

	def index
    	@students = Student.paginate(page: params[:page], per_page: 3)
  	end

	def new
		@student = Student.new
	end

	def edit
		
	end

	def update
		if @student.update(student_params)
      		flash[:notice] = "Your account information was successfully updated"
      		redirect_to @student
    	else
      		render 'edit'
      	end
	end

	def create
	    @student = Student.new(student_params)
	    if @student.save
	      flash[:notice] = "Welcome to the Alpha Blog #{@student.studname}, you have successfully signed up"
	      redirect_to articles_path
	    else
	      render 'new'
	    end
  	end

  	def destroy
	    @student.destroy
	    session[:student_id] = nil
	    flash[:notice] = "Account and all associated articles successfully deleted"
	    redirect_to articles_path
	end

	private
	
	def student_params
	    params.require(:student).permit(:studname, :studemail, :password)
	end

	def set_student
		@student = Student.find(params[:id])
	end

	def require_same_student
	    if current_student != @student
	      flash[:alert] = "You can only edit your own account"
	      redirect_to @student
	    end
	end

end