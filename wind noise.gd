extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pitch_mod = 1
var speed_min = 0
var speed_max = 50
var pitch_min = 1
var pitch_max = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	playing = true
	stream_paused = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = get_parent().velocity.length()
	if speed < 1:
		stream_paused = true
	else:
		stream_paused = false
		volume_db = lerp(volume_db, speed - 36, 0.1)
		pitch_mod = range_lerp(speed, 0, 50, 1, 2)
		pitch_scale = lerp(pitch_scale, pitch_mod, 0.1)
		

