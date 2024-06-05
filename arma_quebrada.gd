extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var spawnPos

func _ready():
	global_position = spawnPos
	await get_tree().create_timer(1).timeout
	queue_free()

func _physics_process(delta):
	velocity.y += gravity * delta
	rotation += 0.5
	
	move_and_slide()
