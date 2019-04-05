class PodcastsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_podcast, except: %i[index new create]

  def index
    @podcasts = current_user.podcasts
  end

  def new
    @podcast = Podcast.new
  end

  def create
    @podcast = Podcast.new(podcast_params.merge(user: current_user))
    if @podcast.save
      redirect_to podcast_path(@podcast), notice: t('.notice')
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @podcast.update(podcast_params)
      redirect_to edit_podcast_path(@podcast), notice: t('.notice')
    else
      render :edit
    end
  end

  def destroy
    @podcast.destroy
    redirect_to podcasts_path, notice: t('.notice')
  end

  private

  def podcast_params
    params.require(:podcast).permit(:title)
  end

  def find_podcast
    @podcast = Podcast.find(params[:id])
  end
end
