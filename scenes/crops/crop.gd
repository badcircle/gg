class_name Crop extends Node3D

var crops_folder : String = "res://assets/crops/"
var test_paths = ["Crop", "Harvested"]
var assets : Dictionary

enum Crops {Apple, Bamboo, Beet, BushBerries, Cactus, Carrot, Corn, Flower, Lettuce, Mushroom, Orange, PalmTree, Pumpkin, Rice, Tomato, Watermelon, Wheat}
const NeedSpace = ['Apple', 'BushBerries', 'Cactus', 'Orange', 'PalmTree']
const stages = 5 # this number should be 1 higher than the actual number of growth stages


@export var crop : Crops
var current_stage : int = randi_range(1,4)
var active_mesh : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(current_stage)
	if (!crop):
		crop = randi_range(0, Crops.size() - 1)
	getStageScene()
	assets = getMatchingAssets()
	#print(assets)

# Called every frame. delta is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func getMatchingAssets() -> Dictionary:
	var data = {}
	for x in range(stages):
		var test_path = str(crops_folder, Crops.keys()[crop], "_", x, ".fbx")
		if FileAccess.file_exists(test_path):
			data[x] = test_path
	for x in test_paths.size():
		var test_path = str(crops_folder, Crops.keys()[crop], "_", test_paths[x], ".fbx")
		if FileAccess.file_exists(test_path):
			data[x+stages] = test_path
	return data

func refresh() -> void:
	assets = getMatchingAssets()

func getStageScene() -> void:
	var path = str(crops_folder, Crops.keys()[crop], "_", current_stage, ".fbx")
	for child in get_children():
		child.free()
	if FileAccess.file_exists(path):
		active_mesh = load(path)
		var thisMesh = active_mesh.instantiate()
		thisMesh.rotation_degrees.y = randi_range(0, 360)
		add_child(thisMesh)
