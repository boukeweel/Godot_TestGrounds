extends Node


signal Score_Changed(new_score: int)
var score : int = 0

signal comboChanged
var comboCount : int = 0;
var AmountHit : int = 0;
var AmountShot : int = 0;

func AddScore(points: int = 100) -> void:
	score += points
	Score_Changed.emit(score)


func HitSuccesfull() -> void:
	comboCount += 1;
	AmountHit += 1
	ComboChanged()
	pass
	
func Missed() -> void:
	comboCount = 0;
	ComboChanged()
	pass
	
func ComboChanged() -> void:
	comboChanged.emit()
	AmountShot += 1;
