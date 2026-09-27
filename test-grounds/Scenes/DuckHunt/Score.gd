extends Node

var label : Label
var label_original_pos : Vector2


func _ready() -> void:
	label = $Label
	label.text = "0";
	label_original_pos = label.position
	ScoreManager.Score_Changed.connect(AddScore)
	pass


func AddScore(points : int) -> void :
	UpdateText(points)
	Shake()

func UpdateText(points : int) -> void :
	#todo if the score reaches some points change the text color
	label.text = str(points)

func Shake() -> void :
	var tween = create_tween()
	var shake_strength = 8.0 #todo later if more score added strong shake
	var shake_count = 4
	var shake_duration = 0.05
	
	for i in range(shake_count) :
		var offset = Vector2(
			randf_range(-shake_strength,shake_strength),
			randf_range(-shake_strength,shake_strength)
		)
		tween.tween_property(label,"position",label_original_pos + offset, shake_duration)
		
	tween.tween_property(label, "position", label_original_pos, shake_duration)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
