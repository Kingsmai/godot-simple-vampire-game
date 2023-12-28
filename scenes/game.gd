extends Node2D

const MOB = preload("res://scenes/mob.tscn")
@onready var enemy_spawn_point: PathFollow2D = %EnemySpawnPoint
@onready var game_over_screen: CanvasLayer = %GameOverScreen


func spawn_mob():
	var new_mob = MOB.instantiate()
	enemy_spawn_point.progress_ratio = randf()
	new_mob.global_position = enemy_spawn_point.global_position
	add_child(new_mob)


func _on_mob_spawn_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	game_over_screen.show()
	get_tree().paused = true
