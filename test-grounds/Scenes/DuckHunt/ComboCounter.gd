extends Node

var label : Label
var label_original_pos : Vector2

@export var StartColor : Color
@export var EndColor : Color

var StartTextSize : int = 20
var ColorChangeMargin : int = 20

func _ready() -> void:
	label = $ComboLabel
	label.text = "0";
	label_original_pos = label.position
	ScoreManager.comboChanged.connect(ComboChanged)
	label.add_theme_font_size_override("font_size",StartTextSize)
	label.add_theme_color_override("font_color",StartColor)
	pass 

func ComboChanged() -> void:
	UpdateText()
	GrowText()
	Shake()
	if ScoreManager.comboCount >= ColorChangeMargin or ScoreManager.comboCount == 0:
		ChangeColor()
		pass
	pass

func ChangeColor() -> void:
	
	var weight : float = (ScoreManager.comboCount - ColorChangeMargin) / 40.0
	if weight > 1:
		weight = 1
	elif weight < 0:
		weight = 0
	
	var newColor : Color = StartColor.lerp(EndColor,weight)
	label.add_theme_color_override("font_color",newColor)
	pass
	

func Shake() -> void :
	var tween = create_tween()
	var shake_strength = ScoreManager.comboCount
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

func UpdateText() -> void:
	label.text = str(ScoreManager.comboCount)
	pass
	
func GrowText() -> void:
	var currentCombo : int = ScoreManager.comboCount
	var newSize : int = currentCombo + StartTextSize
	if newSize >= 40:
		pass
	label.add_theme_font_size_override("font_size",newSize)
	pass
