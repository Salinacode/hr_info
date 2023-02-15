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
      		redirect_to @student, notice: "Your account information was successfully updated"
    	else
      		render 'edit'
      	end
	end

	def create
	    @student = Student.new(student_params)
	    if @student.save
	      redirect_to articles_path, notice: "Welcome to the Alpha Blog #{@student.studname}, you have successfully signed up"	      
	    else
	      render 'new'
	    end
  	end

  	def destroy
	    @student.destroy
	    session[:student_id] = nil if @student == current_student
	    redirect_to articles_path, notice: "Account and all associated articles successfully deleted"
	end

	private
	
	def student_params
	    params.require(:student).permit(:studname, :studemail, :password)
	end

	def set_student
		@student = Student.find(params[:id])
	end

	def require_same_student
	    if current_student != @student && !current_student.admin?
	      flash[:alert] = "You can only edit or delete  your own account"
	      redirect_to @student
	    end
	end

end