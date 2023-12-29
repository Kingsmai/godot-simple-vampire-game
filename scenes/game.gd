extends Node2D

# 预加载敌人场景
const MOB = preload("res://scenes/mob.tscn")
# 敌人生成点
@onready var enemy_spawn_point: PathFollow2D = %EnemySpawnPoint
# 游戏结束画面
@onready var game_over_screen: CanvasLayer = %GameOverScreen


# 生成敌人函数
func spawn_mob():
	var new_mob = MOB.instantiate()
	# 设置敌人生成点位置
	enemy_spawn_point.progress_ratio = randf()
	# 设置敌人的全局位置
	new_mob.global_position = enemy_spawn_point.global_position
	# 将敌人添加为子节点
	add_child(new_mob)


# 敌人生成定时器超时处理函数
func _on_mob_spawn_timer_timeout() -> void:
	spawn_mob()


# 玩家生命值耗尽处理函数
func _on_player_health_depleted() -> void:
	# 显示游戏结束画面
	game_over_screen.show()
	# 暂停游戏树
	get_tree().paused = true
