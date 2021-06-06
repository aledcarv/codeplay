class Api::V1::CoursesController < ActionController::API
    def index
        @courses = Course.all
        render json: @courses.as_json(except: [:id, :created_at, :updated_at, :teacher_id], include: :teacher)
    end

    def show
        @course = Course.find_by(code: params[:code])
        if @course
            render json: @course
        else
            head 404
        end
    end

    def create
        @course = Course.new(course_params)
        @course.save!
        render json: @course, status: :created
    rescue ActiveRecord::RecordInvalid
        render json: @course.errors, status: :unprocessable_entity
    rescue ActionController::ParameterMissing
        render json: { errors: 'Parâmetros inválidos' }, status: :precondition_failed
    end

    private

    def course_params
        params.require(:course).permit(:name, :description, :code, :price, :teacher_id, :enrollment_deadline)
    end
end