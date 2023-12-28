extends CharacterBody2D

var health = 3

@onready var player : CharacterBody2D = $/root/Game/Player


func _ready() -> void:
	%Slime.play_walk()


func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 150.0
	move_and_slide()


func take_damage():
	health -= 1
	%Slime.play_hurt()
	if health == 0:
		queue_free()
