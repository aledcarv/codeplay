class HomeController < ApplicationController
    def index
        @courses = Course.where("enrollment_deadline >= ?", Date.current)
    end
end