extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var storm = Vector3.ZERO
var pin = 0
var pins = [0,1,2,3]
var spin_cycle = 0
var y_cycle = 0
var rng = RandomNumberGenerator.new()
var cycle = Vector3.ZERO
var cycle_factor = 0
var dist = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	cycle_factor = rng.randf_range(-0.7, 0.7)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var heading = Vector3.ZERO
	#storm = get_parent().get_node("KinematicBody").get_node("Attractor").get_global_transform_interpolated().origin
	storm = get_parent().get_node("KinematicBody").get_global_transform_interpolated().origin
	#print(storm)
	dist = distance_to_storm()
	if dist < 600:
		spin_attractor(delta)
		global_translation = global_translation.move_toward(storm + cycle, 0.5)
	
func unpin(p):
	for x in pins:
		if x != p:
			$SoftBody.set_point_pinned(pin, false, get_path_to(get_parent_spatial()))
			
func spin_attractor(delta):
	spin_cycle += delta * (3 + cycle_factor)
	y_cycle += delta * (4 + cycle_factor)
	if spin_cycle > 359:
		spin_cycle -= 360
	var y_mod = cos(y_cycle) / (2 + cycle_factor)
	var spin_sin = sin(spin_cycle)
	var spin_cos = cos(spin_cycle)
	cycle = Vector3(spin_cos + cycle_factor, y_mod + cycle_factor, spin_sin + cycle_factor) * (3 + cycle_factor)
	
func distance_to_storm():
	dist = global_translation.distance_squared_to(storm)
	#print(dist)
	return dist
