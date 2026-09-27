extends Node


signal Score_Changed(new_score: int)
var score : int = 0

func AddScore(points: int = 100) -> void:
	score += points
	Score_Changed.emit(score)
