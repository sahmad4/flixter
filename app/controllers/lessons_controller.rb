class LessonsController < ApplicationController
  before_action :require_authorized_for_current_lesson, only: [:show]

  def show
  end

  private

  def require_authorized_for_current_lesson
    if !current_lesson.section.course.user.enrolled_in?(current_lesson.section.course)
      # render text: "Unauthorized", status: :unauthorized
      redirect_to course_path(current_lesson.section.course), alert: 'You must enroll in this course to view lessons.'
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

end