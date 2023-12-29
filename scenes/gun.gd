extends Area2D
# 这是一个处理射击和目标锁定的简单脚本。

# 预加载子弹场景
const BULLET = preload("res://scenes/bullet.tscn")


# 物理过程处理函数
func _physics_process(delta: float) -> void:
	# 获取范围内的敌人
	var enemies_in_range : Array[Node2D] = get_overlapping_bodies()
	# 如果有敌人
	if enemies_in_range.size() > 0:
		# 锁定目标敌人
		var target_enemy : CharacterBody2D = enemies_in_range.front()
		look_at(target_enemy.global_position)


# 射击函数
func shoot():
	# 实例化新的子弹
	var new_bullet = BULLET.instantiate()
	# 设置子弹的全局位置和旋转
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	# 将子弹添加为子节点
	%ShootingPoint.add_child(new_bullet)

# 定时器超时处理函数
func _on_timer_timeout() -> void:
	# 调用射击函数
	shoot()
