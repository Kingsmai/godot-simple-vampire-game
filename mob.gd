extends CharacterBody2D


@onready var player : CharacterBody2D = $/root/Game/Player


func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 150.0
	move_and_slide()
	
	if velocity.length() > 0.0:
		%Slime.play_walk()
