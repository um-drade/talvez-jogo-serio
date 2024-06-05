extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DEACCEL = 0.9

@onready var particulas = $GPUParticles2D

var tatocandosom = false
var semarma = false

var qntmunicao = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED

	if velocity.x:
		if !direction:
			if velocity.x > 1 or velocity.x < -1:
				velocity.x = velocity.x * DEACCEL
			else:
				velocity.x = 0
		
		if is_on_floor():
			particulas.emitting = true
			if !velocity.x > 50 and !velocity.x < -50:
				particulas.emitting = false
			if velocity.x > 0:
				particulas.position.x = -20
				particulas.position.y = 20
				particulas.process_material.scale_max = velocity.x / 300
			elif velocity.x < 0:
				particulas.position.x = 20
				particulas.position.y = 20
				particulas.process_material.scale_max = velocity.x / 300 * -1
			
	
	if is_on_floor():
		$ColorRect.rotation = 0
		if velocity.x:
			if !tatocandosom:
				tatocandosom = true
				$AudioStreamPlayer.playing = true
			else:
				if velocity.x > 0:
					$AudioStreamPlayer.pitch_scale = 1
					$AudioStreamPlayer.volume_db = velocity.x / 5 - 60
				if velocity.x < 0:
					$AudioStreamPlayer.pitch_scale = 0.9
					$AudioStreamPlayer.volume_db = velocity.x * -1 / 5 - 60
		else:
			$AudioStreamPlayer.playing = false
			tatocandosom = false
	else:
		$AudioStreamPlayer.playing = false
		tatocandosom = false
		
		particulas.emitting = false
		
		$ColorRect.rotation += velocity.x / 3000
	
	
	move_and_slide()


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.playing = true


func player():
	pass

func gerararma():
	var instancia = preload("res://arma.tscn").instantiate()
	self.add_child.call_deferred(instancia)


func _on_touch_screen_button_2_pressed():
	Input.action_press("ui_left")

func _on_touch_screen_button_2_released():
	Input.action_release("ui_left")

func _on_touch_screen_button_3_pressed():
	Input.action_press("ui_right")

func _on_touch_screen_button_3_released():
	Input.action_release("ui_right")

func _on_touch_screen_button_pressed():
	Input.action_press("atira")

func _on_touch_screen_button_released():
	Input.action_release("atira")



