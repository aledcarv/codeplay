class HomeController < ApplicationController
    layout :verify_layout

    def index
        @courses = Course.available.min_to_max
    end

    def verify_layout
        if user_signed_in?
            'admin'
        elsif student_signed_in?
            'student'
        else
            'application'
        end
    end
end