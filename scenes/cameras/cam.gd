extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	toggle_cursor()
	handle_zoom()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.is_action_pressed("rotate_camera"):
		rotation_degrees.y += event.relative.x * -0.1

func toggle_cursor() -> void:
	if Input.is_action_just_released("toggle_cursor"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func handle_zoom() -> void:
	if Input.is_action_just_released("zoom_in"):
		#if $Cam.position.z < 100:
		$Cam.translate_object_local(Vector3(0, 0, -1))
	if Input.is_action_just_released("zoom_out"):
		#if $Cam.position.z > 0:
		$Cam.translate_object_local(Vector3(0, 0, 1))
	#$Cam.position.z = clamp($Cam.position.z, -2, 100)
