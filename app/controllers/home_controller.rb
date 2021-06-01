class HomeController < ApplicationController
    def index
        @courses = Course.available.min_to_max
    end
end