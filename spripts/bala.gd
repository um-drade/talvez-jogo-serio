extends CharacterBody2D

const SPEED = 800

var spawnRot
var spawnPos

func _ready():
	global_position = spawnPos
	global_rotation = spawnRot
	await get_tree().create_timer(1).timeout
	queue_free()

func _physics_process(delta):
	velocity = Vector2(SPEED, 0).rotated(rotation)
	move_and_slide()
