class_name Field extends Node3D

@export var fWidth : int = 6
@export var fHeight : int = 6

var field_state : Dictionary = Dictionary()
const crop : PackedScene = preload("res://scenes/crops/crop.tscn")

@export var crop_scale = 2

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
	pass

func buildField() -> Dictionary:
	var data = Dictionary()
	for w in fWidth:
		for h in fHeight:
			data[Vector2(w, h)] = {"Type": randi_range(0,16), "Stage": 4}
	#print(data)
	return data

func populateField(f : Dictionary) -> void:
	for plot in f.keys():
		#print(plot)
		var newCrop = crop.instantiate()
		newCrop.crop = f[plot].Type
		newCrop.current_stage = f[plot].Stage
		newCrop.position = Vector3(plot.x * crop_scale, 0, plot.y * crop_scale)
		add_child(newCrop)
