class LessonsController < ApplicationController
    before_action :authenticate_user!, only: %i[show]
    before_action :set_course, only: %i[show new create edit update destroy]
    before_action :set_lesson, only: %i[show edit update destroy]
    before_action :user_has_enrollment, only: %i[show]

    def show
    end

    def new
        @lesson = Lesson.new
    end

    def create
        @lesson = @course.lessons.build(lesson_params)

        if @lesson.save
            redirect_to course_path(@course)
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @lesson.update(lesson_params)
            redirect_to course_path(@course)
        else
            render :edit
        end
    end

    def destroy
        @lesson.destroy
        redirect_to @course
    end

    private

        def set_course
            @course = Course.find(params[:course_id])
        end

        def user_has_enrollment
            redirect_to @lesson.course unless current_user.courses.include?(@lesson.course)
        end

        def set_lesson
            @lesson = Lesson.find(params[:id])
        end

        def lesson_params
            params.require(:lesson).permit(:name, :content)
        end
end