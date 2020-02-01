extends KinematicBody2D
 
var minionizingTimer = Timer.new()

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
#			collider.get_node("Anim").play("monster_fade_in" , -1, 0.5)
	
	pass


 