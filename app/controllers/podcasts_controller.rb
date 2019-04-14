class PodcastsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_podcast, except: %i[index new create]

  after_action :store_last_seen_podcast, only: :show

  decorates_assigned :podcast

  def index
    @podcasts = current_user.podcasts
  end

  def new
    authorize(Podcast)
    @podcast = Podcast.new
  end

  def create
    authorize(Podcast)
    @podcast = Podcast.new(create_params.merge(user: current_user))
    if @podcast.save
      redirect_to podcast_path(@podcast), notice: t('.notice')
    else
      render :new
    end
  end

  def show
    authorize(@podcast)
  end

  def edit
    authorize(@podcast)
  end

  def update
    authorize(@podcast)
    if @podcast.update(update_params)
      redirect_to edit_podcast_path(@podcast), notice: t('.notice')
    else
      render :edit
    end
  end

  def destroy
    authorize(@podcast)
    @podcast.destroy
    redirect_to podcasts_path, notice: t('.notice')
  end

  private

  def create_params
    params.require(:podcast).permit(:title)
  end

  def update_params
    params.require(:podcast).permit(:title, :image, :image_cache, :remove_image)
  end

  def find_podcast
    @podcast = Podcast.find(params[:id])
  end

  def store_last_seen_podcast
    session[:last_seen_podcast_id] = @podcast.id
  end
end
