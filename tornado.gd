extends Particles

var dust_color
var angle = 0
var xa
var za
var count
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$tornado_buildup.emitting = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var ray = get_parent().is_colliding()
	if ray:
		var height = get_parent_spatial().global_translation.y - get_parent().get_collision_point().y
		if height < 5 and Input.is_action_pressed("boost"):
			if count < 2:
				count += delta
				var accel_count = clamp(count, 0, 0.5)
				$tornado_buildup.emitting = true
				$tornado_buildup.process_material.tangential_accel = range_lerp(count, 0, 2, 0, 20)
				$tornado_buildup.process_material.radial_accel = range_lerp(accel_count, 0, 0.5, 0, -100)
			else:
				$tornado_buildup.emitting = false
				$tornado_buildup.process_material.tangential_accel = lerp($tornado_buildup.process_material.tangential_accel,
																		100, 0.1)
				var x_fov = get_parent().get_parent().get_node("CamRoot/h/v/ClippedCamera").fov
				get_parent().get_parent().get_node("CamRoot/h/v/ClippedCamera").fov = lerp(x_fov, 100, 0.1)
				var x_v_off = get_parent().get_parent().get_node("CamRoot/h/v/ClippedCamera").v_offset
				get_parent().get_parent().get_node("CamRoot/h/v/ClippedCamera").v_offset = lerp(x_v_off, 5, 0.07)
				emitting = true
				angle += delta * 80
				if angle > 359:
					angle -= 360
				xa = sin(deg2rad(angle)) / 15
				za = cos(deg2rad(angle)) / 15
				process_material.direction.x = xa
				process_material.direction.z = za
				process_material.scale = 2.9 - (height / 5)
				#process_material.emission_ring_radius = height / 2
				#draw_pass_1.radius = 3 - (height/7)
				#draw_pass_1.height = draw_pass_1.radius * 2
				#dust_color = draw_pass_1.material.albedo_color
				#dust_color.a = range_lerp(height, 40, 0, 0, 0.3)
				#draw_pass_1.material.albedo_color = dust_color
				#process_material.gravity.y = 60 - (height)
				global_translation.y = get_parent().get_collision_point().y
		else:
			$tornado_buildup.emitting = false
			var x_fov = get_parent().get_parent().get_node("CamRoot/h/v/ClippedCamera").fov
			get_parent().get_parent().get_node("CamRoot/h/v/ClippedCamera").fov = lerp(x_fov, 70, 0.1)
			var x_v_off = get_parent().get_parent().get_node("CamRoot/h/v/ClippedCamera").v_offset
			get_parent().get_parent().get_node("CamRoot/h/v/ClippedCamera").v_offset = lerp(x_v_off, 0, 0.07)
			count = 0
			emitting = false
