class CoursesController < ApplicationController
    before_action :get_school

    def index
        @courses = Course.where(school_id: @school.id)
    end

    def new
        @course = Course.new
    end

    def create
        @course = @school.courses.new(course_params)
        if @course.save
            redirect_to school_courses_path, notice: 'Course created successfully.'
        else
            render :new
        end
    end

    def edit
    end

    def update
    end

    def destroy
    end


    private

        def get_school
            @school = School.find(params[:school_id])
        end

        def course_params
            params.require(:course).permit(:level, :name)
        end
end