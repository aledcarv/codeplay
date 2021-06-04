class Admin::CoursesController < Admin::AdminController
    before_action :set_course, only: %i[show edit update destroy enroll]

    def index
        @courses = Course.all
    end

    def show
    end

    def new
        @teachers = Teacher.all
        @course = Course.new
    end

    def create
        @course = Course.new(course_params)

        if @course.save
            redirect_to admin_course_path(@course)
        else
            @teachers = Teacher.all
            render :new
        end
    end

    def edit
        @teachers = Teacher.all
    end

    def update
        if @course.update(course_params)
            redirect_to admin_course_path(@course)
        else
            @teachers = Teacher.all
            render :edit
        end
    end

    def destroy
        @course.destroy
        redirect_to admin_courses_path
    end

    private
        def set_course
            @course = Course.find(params[:id])
        end

        def course_params
            params.require(:course).permit(:name, :description, :code, :price, :teacher_id, :enrollment_deadline)
        end
end