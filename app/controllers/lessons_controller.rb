class LessonsController < ApplicationController
    before_action :set_course, only: %i[show new create edit update destroy]
    before_action :set_lesson, only: %i[show edit update destroy]

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

        def set_lesson
            @lesson = Lesson.find(params[:id])
        end

        def lesson_params
            params.require(:lesson).permit(:name, :content)
        end
end