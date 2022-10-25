extends Particles

var dust_color
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var ray = get_parent().is_colliding()
	if ray:
		emitting = true
		var height = get_parent_spatial().global_translation.y - get_parent().get_collision_point().y
		process_material.emission_ring_radius = height / 2
		draw_pass_1.radius = 3 - (height/7)
		draw_pass_1.height = draw_pass_1.radius * 2
		dust_color = draw_pass_1.material.albedo_color
		dust_color.a = range_lerp(height, 40, 0, 0, 0.3)
		draw_pass_1.material.albedo_color = dust_color
		process_material.gravity.y = 60 - (height)
		global_translation.y = get_parent().get_collision_point().y
	else:
		emitting = false
