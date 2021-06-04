class Admin::TeachersController < Admin::AdminController
    before_action :set_teacher, only: %i[show edit update destroy]

    def index
        @teachers = Teacher.all
    end

    def show
    end

    def new
        @teacher = Teacher.new
    end

    def create
        @teacher = Teacher.new(teacher_params)

        if @teacher.save
            redirect_to admin_teacher_path(@teacher)
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @teacher.update(teacher_params)
            redirect_to admin_teacher_path(@teacher)
        else
            render :edit
        end
    end

    def destroy
        @teacher.destroy
        redirect_to admin_teachers_path
    end

    private

        def set_teacher
            @teacher = Teacher.find(params[:id])
        end

        def teacher_params
            params.require(:teacher).permit(:name, :email, :bio, :profile_picture)
        end
end