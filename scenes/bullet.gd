extends Area2D

# 已移动的距离
var travelled_distance = 0
# 移动速度
const SPEED = 1000.0
# 最大移动范围
const RANGE = 1200.0

# 物理过程处理函数
func _physics_process(delta: float) -> void:
	# 计算移动方向
	var direction = Vector2.RIGHT.rotated(rotation)
	# 更新位置
	position += direction * SPEED * delta
	# 更新已移动的距离
	travelled_distance = SPEED * delta
	# 检查是否超出范围，是则释放节点
	if travelled_distance > RANGE:
		queue_free()

# 物体进入区域的处理函数
func _on_body_entered(body: Node2D) -> void:
	# 释放节点
	queue_free()
	# 检查物体是否具有“take_damage”方法，是则调用
	if body.has_method("take_damage"):
		body.take_damage()
