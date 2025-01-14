class_name Field extends Node3D

@export var fWidth : int = 3
@export var fHeight : int = 3

var field_state : Dictionary = Dictionary()
const crop : PackedScene = preload("res://scenes/crops/crop.tscn")

@export var crop_scale = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	field_state = buildField()
	populateField(field_state)
	$Dirt.mesh.size.x = $Dirt.mesh.size.x * crop_scale
	$Dirt.mesh.size.z = $Dirt.mesh.size.z * crop_scale
	$Dirt.position.x = fWidth * crop_scale * 0.5 - 0.5 * crop_scale
	$Dirt.position.z = fHeight * crop_scale * 0.5 - 0.5 * crop_scale
	$Cam_Rot.position = $Dirt.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("grow"):
		for plot in field_state.keys():
			grow(plot)

func buildField() -> Dictionary:
	var data = Dictionary()
	for w in fWidth:
		for h in fHeight:
			data[Vector2(w, h)] = {"Type": randi_range(0,16), "Stage": 1, "Scene": null}
	#print(data)
	return data

func populateField(f : Dictionary) -> void:
	for plot in f.keys():
		#print(plot)
		var newCrop = crop.instantiate()
		f[plot].Scene = newCrop
		newCrop.crop = f[plot].Type
		newCrop.current_stage = f[plot].Stage
		newCrop.position = Vector3(plot.x * crop_scale, 0, plot.y * crop_scale)
		add_child(newCrop)

func grow(xy: Vector2) -> void:
	field_state[xy].Stage = field_state[xy].Stage + 1
	field_state[xy].Stage = wrapi(field_state[xy].Stage, 0, 6)
	field_state[xy].Scene.current_stage = field_state[xy].Stage
	field_state[xy].Scene.getStageScene()
