class_name Sax extends Node3D

@onready var A : AudioStreamPlayer = $"Sax-A"
@onready var C : AudioStreamPlayer = $"Sax-C"
@onready var D : AudioStreamPlayer = $"Sax-D"
@onready var F : AudioStreamPlayer = $"Sax-F"
@onready var G : AudioStreamPlayer = $"Sax-G"

@onready var notes : Array[AudioStreamPlayer] = [A, C, D, F, G]

var pitch_scale : float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	play_notes()
	shift_pitch(delta)
	update_label()

func play_notes() -> void:
	if Input.is_action_just_pressed("play_A"):
		A.playing = true
	if Input.is_action_just_pressed("play_C"):
		C.playing = true
	if Input.is_action_just_pressed("play_D"):
		D.playing = true
	if Input.is_action_just_pressed("play_F"):
		F.playing = true
	if Input.is_action_just_pressed("play_G"):
		G.playing = true

func shift_pitch(diff) -> void:
	var shiftDir = Input.get_axis("shift_pitch_down", "shift_pitch_up") + 1.0
	pitch_scale = move_toward(pitch_scale, shiftDir, diff)
	pitch_scale = clamp(pitch_scale, 0.5, 1.5)
	for note in notes:
		note.pitch_scale = pitch_scale
		note.max_polyphony = 16

func update_label() -> void:
	$Label.text = "Pitch: %.2f" % pitch_scale
