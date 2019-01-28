function cycle_video_rotate(direction)
  local rotate = mp.get_property_number("video-rotate")
  rotate = rotate + (direction == "cw" and -90 or 90)
  rotate = rotate % 360

	mp.set_property_number("video-rotate", rotate)
	mp.osd_message("Rotate: " .. rotate)
end

mp.add_key_binding(nil, "Cycle_Video_Rotate", cycle_video_rotate)
