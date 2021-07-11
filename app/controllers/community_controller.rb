class CommunityController < ApplicationController
  before_action :set_lecture, only: [:edit, :update, :destroy]
  before_action :set_lecture_by_key, only: [:show, :slides, :print]
  before_action :set_renderer, only: [:show, :print]
  layout 'menuless', only: [:slides]

  def index
    @q = Lecture.where(community: true).accessible_by(current_ability).ransack(params[:q])
    @lectures = @q.result(distinct: true)
    @lectures = Lecture.where(community: true).accessible_by(current_ability) if @lectures.empty?
    render "lectures/index"
  end
end
