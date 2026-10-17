extends Node2D


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Shoot"):
		var space := get_world_2d().direct_space_state
		var query := PhysicsPointQueryParameters2D.new()
		query.position = get_global_mouse_position()
		query.collide_with_bodies = true
		var results := space.intersect_point(query, 1)

		if results.is_empty():
			ScoreManager.Missed()
		else:
			var target = results[0].collider
			if target.has_method("Death"):
				target.Death()
				ScoreManager.HitSuccesfull()
			else:
				ScoreManager.Missed()
