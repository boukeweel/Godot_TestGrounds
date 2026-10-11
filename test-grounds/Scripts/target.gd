extends RigidBody2D



var throw_force: Vector2 
@export var max_distance: float = 2000.0

var rand = RandomNumberGenerator.new()

var spawn_position: Vector2
var TargetPieces : PackedScene = preload("res://Scenes/DuckHunt/target_pieces.tscn")


func _ready() -> void:
	input_pickable = true
	spawn_position = global_position
	
	#IT should make a more bow like wave, instead of bow.
	#if its position is to the left, it should always goes to the right
	#if its position is more in the middle, it can go both ways
	#if its position is to the right, it should always goes to the left
	
	var spawnPos : Vector2 = position
	var xForce : float
	if(spawnPos.x < -150):
		xForce = rand.randf_range(50,500)
	elif(spawnPos.x > 150):
		xForce = rand.randf_range(-500,-50)
	else :
		xForce = rand.randf_range(-250,250)
	var yForce : float = rand.randf_range(-800,-1000)
	
	throw_force = Vector2(xForce,yForce);
	apply_central_impulse(throw_force)

func _physics_process(_delta: float) -> void:
	if global_position.distance_to(spawn_position) > max_distance:
		queue_free()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event.is_action_pressed("Shoot")) :
		Death()
	pass # Replace with function body.


func Death() -> void :
	ScoreManager.AddScore()
	SpawnPieces()
	queue_free()
	pass
	
func SpawnPieces() -> void: 
	var baseOffset: int = 16
	var spread: float = baseOffset * 0.5  # distance from center to each piece's center

	# bottom right, bottom left, top left, top right
	var directions: Array[Vector2] = [
		Vector2(1, 1),
		Vector2(-1, 1),
		Vector2(-1, -1),
		Vector2(1, -1),
	]

	for n in 4:
		var piece: RigidBody2D = TargetPieces.instantiate()
		piece.position = position + directions[n] * spread

		var rndMulti : float = rand.randf_range(40,200);
		var force : Vector2 = directions[n] * rndMulti
		throw_force = Vector2(force)
		piece.apply_central_impulse(throw_force)
		

		var sprite: Sprite2D = piece.get_node("Collider/Sprite2D")
		sprite.region_enabled = true

		var rect: Rect2 = sprite.region_rect
		rect.position.x = baseOffset * (n + 1)
		sprite.region_rect = rect

		get_tree().current_scene.add_child(piece)
	pass
