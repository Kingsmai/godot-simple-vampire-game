extends CharacterBody2D

# 初始生命值
var health := 3
# 移动速度
var SPEED := 150.0
# 找到玩家，以便追踪
@onready var player : CharacterBody2D = $/root/Game/Player
# 预加载烟雾爆炸场景
const SMOKE_EXPLOSION = preload("res://smoke_explosion/smoke_explosion.tscn")


# 在场景就绪时调用的函数
func _ready() -> void:
	# 播放行走动画
	%Slime.play_walk()


# 物理过程处理函数
func _physics_process(delta: float) -> void:
	# 计算朝向玩家的方向
	var direction = global_position.direction_to(player.global_position)
	# 设置速度
	velocity = direction * SPEED
	# 移动并滑动
	move_and_slide()


# 受伤处理函数
func take_damage():
	# 减少生命值
	health -= 1
	# 播放受伤动画
	%Slime.play_hurt()
	# 如果生命值为零，则释放节点
	if health == 0:
		queue_free()
		# 实例化烟雾爆炸
		var smoke = SMOKE_EXPLOSION.instantiate()
		smoke.global_position = global_position
		# 将烟雾爆炸添加为父节点的子节点
		get_parent().add_child(smoke)
