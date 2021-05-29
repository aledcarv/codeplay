class LessonsController < ApplicationController
    def show
        @course = Course.find(params[:course_id])
        @lesson = Lesson.find(params[:id])
    end

    def new
        @course = Course.find(params[:course_id])
        @lesson = Lesson.new
    end

    def create
        @course = Course.find(params[:course_id])
        @lesson = @course.lessons.build(lesson_params)

        if @lesson.save
            redirect_to course_path(@course)
        else
            render :new
        end
    end

    def edit
        @course = Course.find(params[:course_id])
        @lesson = Lesson.find(params[:id])
    end

    def update
        @course = Course.find(params[:course_id])
        @lesson = Lesson.find(params[:id])

        if @lesson.update(lesson_params)
            redirect_to course_path(@course)
        else
            render :edit
        end
    end

    def destroy
        @course = Course.find(params[:course_id])
        @lesson = Lesson.find(params[:id])
        @lesson.destroy
        redirect_to @course
    end

    private

        def lesson_params
            params.require(:lesson).permit(:name, :content)
        end
end