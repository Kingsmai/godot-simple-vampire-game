extends Node2D

var rng = RandomNumberGenerator.new()

# 预加载敌人场景
const MOB = preload("res://scenes/mob.tscn")
# 敌人生成点
@onready var enemy_spawn_point: PathFollow2D = %EnemySpawnPoint
# 游戏结束画面
@onready var game_over_screen: CanvasLayer = %GameOverScreen

const PINE_TREE = preload("res://scenes/pine_tree.tscn")
const CHUNK_SIZE = Vector2i(1280, 720)

var loaded_chunks : Array[Vector2i] = []


func _ready() -> void:
	load_chunk()


# 生成敌人函数
func spawn_mob():
	var new_mob = MOB.instantiate()
	# 设置敌人生成点位置
	enemy_spawn_point.progress_ratio = randf()
	# 设置敌人的全局位置
	new_mob.global_position = enemy_spawn_point.global_position
	# 将敌人添加为子节点
	add_child(new_mob)


func load_chunk():
	var player_pos := (%Player as CharacterBody2D).global_position
	var chunk_pos := Vector2i(int(player_pos.x / CHUNK_SIZE.x), int(player_pos.y / CHUNK_SIZE.y))
	if chunk_pos not in loaded_chunks:
		spawn_trees(chunk_pos)
	if chunk_pos + Vector2i.UP not in loaded_chunks:
		spawn_trees(chunk_pos + Vector2i.UP)
	if chunk_pos + Vector2i.DOWN not in loaded_chunks:
		spawn_trees(chunk_pos + Vector2i.DOWN)
	if chunk_pos + Vector2i.LEFT not in loaded_chunks:
		spawn_trees(chunk_pos + Vector2i.LEFT)
	if chunk_pos + Vector2i.RIGHT not in loaded_chunks:
		spawn_trees(chunk_pos + Vector2i.RIGHT)


# 生成树木群
func spawn_trees(chunk : Vector2i):
	var tree_count = randi_range(1, 10)
	for i in range(tree_count):
		# Spawn tree
		var tree = PINE_TREE.instantiate()
		tree.global_position = Vector2i(
			rng.randi_range(0 + chunk.x * CHUNK_SIZE.x, CHUNK_SIZE.x + chunk.x * CHUNK_SIZE.x), 
			rng.randi_range(0 + chunk.y * CHUNK_SIZE.y, CHUNK_SIZE.y + chunk.y * CHUNK_SIZE.y)
		)
		add_child(tree)
	print("Tree spawned at: ", chunk)
	loaded_chunks.append(chunk)

# 敌人生成定时器超时处理函数
func _on_mob_spawn_timer_timeout() -> void:
	spawn_mob()


func _on_player_state_update_timer_timeout() -> void:
	load_chunk()


# 玩家生命值耗尽处理函数
func _on_player_health_depleted() -> void:
	# 显示游戏结束画面
	game_over_screen.show()
	# 暂停游戏树
	get_tree().paused = true
