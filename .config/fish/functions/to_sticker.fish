function to_sticker --wraps=ffmpeg
  ffmpeg -i $argv[1] -vf "scale=512:512:force_original_aspect_ratio=decrease"  $argv[1]'.webp'
end
