extends CharacterBody2D

# 生命值耗尽信号
signal health_depleted

# 初始生命值
var health := 100.0

# 伤害速率
const DAMAGE_RATE := 5.0

# 生命值条
@onready var health_bar: ProgressBar = $HealthBar

# 在场景就绪时调用的函数
func _ready() -> void:
	# 设置生命值条的最大值和初始值
	health_bar.max_value = health
	health_bar.value = health

# 物理过程处理函数
func _physics_process(delta: float) -> void:
	# 获取移动方向
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	# 设置速度
	velocity = direction * 600
	# 移动并滑动
	move_and_slide()
	
	# 播放行走或站立动画
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	
	# 检查与HurtBox重叠的敌人
	var overlapping_mobs = (%HurtBox as Area2D).get_overlapping_bodies()
	# 如果有重叠的敌人
	if overlapping_mobs.size() > 0:
		# 减少生命值
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		# 更新生命值条
		health_bar.value = health
		# 如果生命值小于等于零，发射生命值耗尽信号
		if health <= 0.0:
			# 游戏结束
			health_depleted.emit()
