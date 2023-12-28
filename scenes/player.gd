extends CharacterBody2D

signal health_depleted

var health := 100.0
const DAMAGE_RATE := 5.0

@onready var health_bar: ProgressBar = $HealthBar


func _ready() -> void:
	health_bar.max_value = health
	health_bar.value = health

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide()
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	
	var overlapping_mobs = (%HurtBox as Area2D).get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		health_bar.value = health
		if health <= 0.0:
			# Game over
			health_depleted.emit()
