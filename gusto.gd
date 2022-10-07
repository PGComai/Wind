extends KinematicBody

export var speed = 50
export var strength = 5
export var spin = 5

var velocity = Vector3.ZERO
var input_vector = Vector3.ZERO
var h_rot
var spin_cycle = 0
var y_cycle = 0
var rng = RandomNumberGenerator.new()

func _init():
	var direction = Vector3.ZERO
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("click"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	if event.is_action_pressed("toggle_mouse"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	h_rot = $CamRoot/h.global_transform.basis.get_euler().y
	if Input.is_action_pressed("go"):
		input_vector = get_input_vector(h_rot)
		apply_movement(input_vector)
		#print(input_vector)
		$Velocity.look_at(velocity * 100, Vector3.UP)
	else:
		slow_down()
	#velocity = velocity.rotated(Vector3.UP, h_rot)
	
	velocity = move_and_slide(velocity, Vector3.UP)
	#spin_attractor(delta)
	

func get_input_vector(h_rot):
	var input_vector = Vector3.ZERO
	input_vector.x = sin(h_rot)
	input_vector.z = cos(h_rot)
	input_vector.y = -sin($CamRoot/h/v.global_transform.basis.get_euler().x)
	return input_vector.normalized() if input_vector.length() > 1 else input_vector

func apply_movement(input_vector):
	velocity.x = lerp(velocity.x, input_vector.x * speed, 0.01)
	velocity.z = lerp(velocity.z, input_vector.z * speed, 0.01)
	velocity.y = lerp(velocity.y, input_vector.y * speed, 0.01)
	
func slow_down():
	velocity.x = lerp(velocity.x, 0, 0.03)
	velocity.z = lerp(velocity.z, 0, 0.03)
	velocity.y = lerp(velocity.y, 0, 0.03)

func return_pos():
	var x = get_global_transform_interpolated().origin
	return x
	
func spin_attractor(delta):
	spin_cycle += delta * 3
	y_cycle += delta * 4
	if spin_cycle > 359:
		spin_cycle -= 360
	var y_mod = cos(y_cycle) / 2
	var spin_sin = sin(spin_cycle)
	var spin_cos = cos(spin_cycle)
	$Attractor.translation = Vector3(spin_cos, y_mod, spin_sin) * 3
