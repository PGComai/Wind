extends Spatial

var rot_h = 0
var rot_v = 0
var v_min = -60
var v_max = 55
var h_sensitivity = 0.1
var v_sensitivity = 0.1
var h_acc
var v_acc

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$h/v/ClippedCamera.add_exception(get_parent())
	
func _input(event):
	if event is InputEventMouseMotion:
		rot_h -= event.relative.x * h_sensitivity
		rot_v -= event.relative.y * v_sensitivity
		
func _physics_process(delta):
	
	rot_v = clamp(rot_v, v_min, v_max)
	
	$h.rotation_degrees.y = rot_h
	$h/v.rotation_degrees.x = rot_v
