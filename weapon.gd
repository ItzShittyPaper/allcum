extends KinematicBody

onready var raycast = get_node("/root/Spatial/Player/Head/Camera/RayCast")
onready var animation_fire = get_node("AnimationPlayerFire")
onready var animation_walk = get_node("AnimationPlayerWalk")
onready var audio = get_node("AudioStreamPlayer3D")
onready var camera = get_node("/aha.tscn/root/Spatial/Player/Head/Camera")

export var damage = 20
export var rate_of_fire = 4
var spread = 4

# ---------------------------

func _ready():
	animation_fire.set_speed_scale(rate_of_fire)

func _physics_process(delta):
	fire()
	walkinganim()

# ---------------------------

func walkinganim():
	if Input.is_action_pressed("forward"):
		animation_walk.play("walk")
	elif Input.is_action_pressed("backward"):
		animation_walk.play("walk")
	elif Input.is_action_pressed("left"):
		animation_walk.play("walk")
	elif Input.is_action_pressed("right"):
		animation_walk.play("walk")
	else:
		animation_walk.stop()

func fire():
	if Input.is_action_pressed("primary_attack"):	if Input.is_action_pressed("forward"):
		if not animation_fire.is_playing():
			audio.play()
			animation_fire.play("fire")
			raycast.translation = lerp(camera.translation, 
				Vector3(rand_range(spread, -spread), 
				rand_range(spread, -spread), 0), 0.5)
			if raycast.is_colliding():
				var target = raycast.get_collider()
				if target.is_in_group("entity"):
					print("firing")
					print(target.health)
					target.health -= damage
	else:
		raycast.translation = Vector3()
		animation_fire.stop()
