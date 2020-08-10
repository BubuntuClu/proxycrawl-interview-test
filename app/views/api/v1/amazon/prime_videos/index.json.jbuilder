json.prime_videos do
  json.array! @prime_videos do |video|
    json.partial! 'preview_prime_video', locals: { video: video }
  end
end
