extends Particles


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	restart()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = get_parent().get_parent().velocity.length()
	if speed < 1:
		emitting = false
	else:
		emitting = true
		process_material.initial_velocity = speed / 5
