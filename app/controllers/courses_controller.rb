class CoursesController < ApplicationController
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
            redirect_to @course
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
            redirect_to @course
        else
            @teachers = Teacher.all
            render :edit
        end
    end

    def destroy
        @course.destroy
        redirect_to courses_path
    end

    def enroll
        Enrollment.create!(user: current_user, course: @course)
        redirect_to my_enroll_courses_path, notice: 'Curso comprado com sucesso'
    end

    def my_enroll
        @enrollments = current_user.enrollments
    end

    private
        def set_course
            @course = Course.find(params[:id])
        end

        def course_params
            params.require(:course).permit(:name, :description, :code, :price, :teacher_id, :enrollment_deadline)
        end
end