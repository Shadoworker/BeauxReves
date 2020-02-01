extends KinematicBody2D
 

var raycast : RayCast2D

func _ready():
	
	raycast = $RayCast2D
	 
	pass

func _physics_process(delta):
	 
 
	if(raycast.is_colliding()):
		
		var collider = raycast.get_collider()
		if(collider.is_in_group("monsters")):
			collider.modulate = Color(0,255,0)
			queue_free()
	
	pass

 