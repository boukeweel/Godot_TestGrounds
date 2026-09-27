extends Node2D

@export var time_fire : float = 4
var currentTimer : float = 0;
var Targets : Array[PackedScene] = [
	preload("res://Scenes/DuckHunt/target.tscn")
]

var rand = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	currentTimer += delta;
	if (currentTimer >= time_fire):
		currentTimer -= time_fire;
		Spawn_Random_Object();	
	
	pass
	
func Spawn_Random_Object() -> void:
	var scene: PackedScene = Targets.pick_random()
	var target: Node = scene.instantiate()
	
	var xPos : float = rand.randf_range(-550,550)
	target.position = Vector2(xPos, position.y)
	
	add_child(target);
	pass
