extends RigidBody2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var dir_ray : RayCast2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	dir_ray = $dir_ray
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _physics_process(delta):
	 
		
#
#	if(dir_ray.is_colliding()):
#
#		var collider = dir_ray.get_collider()
#		# SET CIRCLE TARGET FOLLOWING CURRENT ONE 
#		var dir = collider.name
#		print_debug(dir)
#
#		pass

	pass



func _on_DOWN_body_entered(body: PhysicsBody2D) -> void:
	print_debug(body)
	
	pass # Replace with function body.
