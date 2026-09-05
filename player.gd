extends CharacterBody3D

@export  var mouse_sensitvity = 0.002
@onready var Camera: Camera3D = $Camera3D
var camera_rotation = 0.0
const SPEED = 5.0



func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			rotate_y(event.relative.x * -mouse_sensitvity)
			camera_rotation -= event.relative.y * mouse_sensitvity
			camera_rotation = clamp(camera_rotation, deg_to_rad(-85), deg_to_rad(85))
			Camera.rotation.x = camera_rotation
			
			
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(_delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("A", "D", "W", "S")
	var direction := (Camera.global_transform.basis * Vector3(0, 0, input_dir.y)).normalized()
	if direction:
		velocity = direction * SPEED

	move_and_slide()
