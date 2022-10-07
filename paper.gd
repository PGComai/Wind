extends SoftBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var storm = Vector3.ZERO
var heading = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	storm = get_parent().get_node("KinematicBody").get_global_transform_interpolated().origin

	heading = global_translation.move_toward(storm, 0.1)
	
	translate(heading)

