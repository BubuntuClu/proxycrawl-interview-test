class Amazon::PrimeVideo::UpdateService
  def self.call(params)
    prime_video = ::Amazon::PrimeVideo::FindService.call(params[:id])
    prime_video.update(prime_video_params(params))
    prime_video
  end

  private

  def self.prime_video_params(params)
    params.require(:amazon_good).permit(:rel_canonical, meta_info: {}, general_info: {})
  end
end
