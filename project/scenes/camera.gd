extends Camera2D

var mouse_pos_clicked := Vector2()
var cam_pos_clicked := Vector2()

func _process(_delta: float):
	# Pan the camera on right click
	var mouse_pos = get_viewport().get_mouse_position() / zoom
	if Input.is_action_just_pressed("alt_click") or Input.is_action_just_released("alt_click"):
		mouse_pos_clicked = mouse_pos
		cam_pos_clicked = offset
	if Input.is_action_pressed("alt_click"):
		offset = cam_pos_clicked + (mouse_pos_clicked - mouse_pos)

	# Zoom the camera
	if Input.is_action_just_pressed("zoom_in"):
		zoom *= 2
	if Input.is_action_just_pressed("zoom_out"):
		zoom /= 2
