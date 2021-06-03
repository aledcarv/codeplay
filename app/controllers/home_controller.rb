class HomeController < ApplicationController
    layout :verify_layout

    def index
        @courses = Course.available.min_to_max
    end

    def verify_layout
        return 'admin' if user_signed_in?

        'application'
    end
end