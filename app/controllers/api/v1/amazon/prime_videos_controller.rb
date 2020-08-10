class Api::V1::Amazon::PrimeVideosController < Api::V1::ApplicationController
  def index
    @prime_videos = ::Amazon::PrimeVideo::IndexService.call
  end

  def show
    @prime_video = ::Amazon::PrimeVideo::FindService.call(params[:id])
  end

  def destroy
    @prime_video = ::Amazon::PrimeVideo::DestroyService.call(params)
  end

  def update
    @prime_video = ::Amazon::PrimeVideo::UpdateService.call(params)
  end
end
