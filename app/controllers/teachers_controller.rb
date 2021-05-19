class TeachersController < ApplicationController
    def index
        @teachers = Teacher.all
    end

    def show
        @teacher = Teacher.find(params[:id])
    end

    def new
        @teacher = Teacher.new
    end

    def create
        @teacher = Teacher.new(teacher_params)

        if @teacher.save
            redirect_to @teacher
        else
            render :new
        end
    end

    private

        def teacher_params
            params.require(:teacher).permit(:name, :email, :bio, :profile_picture)
        end
end