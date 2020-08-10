class Amazon::PrimeVideo::DestroyService
  def self.call(params)
    prime_video = ::Amazon::PrimeVideo::FindService.call(params[:id])
    prime_video.destroy
  end
end
