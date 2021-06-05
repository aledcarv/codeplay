class Student::LessonsController < Student::StudentController
    before_action :authenticate_student!, only: %i[show]
    before_action :set_course, only: %i[show]
    before_action :set_lesson, only: %i[show]
    before_action :user_has_enrollment, only: %i[show]

    def show
    end

    private

        def set_course
            @course = Course.find(params[:course_id])
        end

        def user_has_enrollment
            redirect_to [:student, @lesson.course] unless current_student.courses.include?(@lesson.course)
        end

        def set_lesson
            @lesson = Lesson.find(params[:id])
        end

        def lesson_params
            params.require(:lesson).permit(:name, :content)
        end
end