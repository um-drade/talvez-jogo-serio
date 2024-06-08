extends Node2D



@onready var sprite = %Shotgun
@onready var pivo = $"pivo da arma"
@onready var alvo = get_node("/root/mundo/alvo").global_position
@onready var bala = preload("res://bala.tscn")
@onready var mundo = get_tree().get_root().get_node("mundo")
@onready var saidabala = $"pivo da arma/Marker2D"
@onready var player = get_node("/root/mundo/player")

var rotdeg = rotation_degrees

func _physics_process(delta):
	var v = alvo - global_position
	var angle = v.angle()
	var r = global_rotation
	
	global_rotation = lerp_angle(r, angle, .05)
	
	pivo.look_at(alvo)
	
	if !pivo.global_rotation_degrees < 90 or !pivo.global_rotation_degrees > -90:
		sprite.flip_v = true
		$"pivo da arma/Marker2D".position.y = 4
	else:
		sprite.flip_v = false
		$"pivo da arma/Marker2D".position.y = -4

func _input(event):
	if event.is_action_pressed("atira"):
		atira()

func atira():
	if get_node("/root/mundo/player").qntmunicao:
		for i in range(5):
			var instancia = bala.instantiate()
			instancia.spawnPos = saidabala.global_position
			instancia.spawnRot = pivo.global_rotation + randf_range(-0.1, 0.1)
			instancia.spawnPos += Vector2(randf_range(0, 20), 0).rotated(instancia.spawnRot)
			mundo.add_child.call_deferred(instancia)
	get_node("/root/mundo/player").qntmunicao -= 1
	if !get_node("/root/mundo/player").qntmunicao:
		destruirarma()

func destruirarma():
	var instancia = preload("res://arma_quebrada.tscn").instantiate()
	instancia.spawnPos = pivo.global_position
	instancia.velocity = Vector2(randf_range(-100, 100), -200)
	get_tree().get_root().add_child.call_deferred(instancia)
	queue_free()
