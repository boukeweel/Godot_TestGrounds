extends Node

var label : Label
var label_original_pos : Vector2

func _ready() -> void:
	label = $ComboLabel
	label.text = "0";
	label_original_pos = label.position
	ScoreManager.comboChanged.connect(ComboChanged)
	pass 

func ComboChanged() -> void:
	UpdateText()
	pass

func UpdateText() -> void:
	label.text = str(ScoreManager.comboCount)
