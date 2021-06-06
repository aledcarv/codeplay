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
end