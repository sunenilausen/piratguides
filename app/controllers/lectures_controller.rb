class LecturesController < ApplicationController
  load_and_authorize_resource only: [:new, :create, :update, :destroy]
  before_action :set_lecture, only: [:edit, :update, :destroy]
  before_action :set_lecture_by_key, only: [:show, :slides, :print]
  before_action :set_renderer, only: [:show, :print]
  layout 'menuless', only: [:slides]

  # GET /lectures/1
  def show
  end

  # GET /lectures/new
  def new
    @lecture = Lecture.new
    @lecture.article_insertions.build.article.build
  end

  # GET /lectures/1/edit
  def edit
    #@lecture.article_insertions.build.build_article
  end

  # POST /lectures
  def create
    @lecture = Lecture.new(lecture_params)
    if @lecture.save
      redirect_to @lecture, notice: 'Lecture was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /lectures/1
  def update
    if @lecture.update(lecture_params)
      redirect_to @lecture, notice: 'Lecture was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /lectures/1
  def destroy
    @lecture.destroy
    redirect_to lectures_url, notice: 'Lecture was successfully destroyed.'
  end

  def slides
  end

  def print
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture
      @lecture = Lecture.find(params[:id])
    end

    def set_lecture_by_key
      if params[:workshop]
        workshop = Workshop.find_by(key: params[:workshop])
        @lecture = Lecture.find_by(number: params[:lecture], workshop_id: workshop.id)
      else
        set_lecture
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lecture_params
      params.require(:lecture).permit(
        :active,
        :body,
        :number,
        :preview,
        :preview_image_url,
        :prologue,
        :title,
        :workshop_id,
        article_insertions_attributes: [
          :id,
          :number,
          :article_id,
          :_destroy,
          article_attributes: [
            :id,
            :title,
            :key,
            :body,
            :active,
            :_destroy
          ]
        ]
      )
    end
end
