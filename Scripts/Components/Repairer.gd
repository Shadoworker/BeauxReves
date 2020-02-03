extends KinematicBody2D
 
var minionizingTimer = Timer.new()
var auto_destroyTimer = Timer.new()
var raycast : RayCast2D

func _ready():
	
	raycast = $RayCast2D
	
	__init_auto_destroying()
	
	pass

func _physics_process(delta):
	 
 
	if(raycast.is_colliding()):
		
		var collider = raycast.get_collider()
		if(collider.is_in_group("monsters")):
			
			SignalsManager.emit_signal("_s_toyRepaired")
			SignalsManager.emit_signal("_s_toyEnded")
#			collider.modulate = Color(0,255,0)
			collider.get_node("monster_sprite").frame = 1
			collider.get_node("Monster_weapon").enabled = false
			
			collider.set("minionized" , true)
			queue_free()
#			collider.get_node("Anim").play("monster_fade_in" , -1, 0.5)
	
	pass



func __auto_destroy():
	 
	queue_free()
	
	pass

#ENEMIES GET ORDER TO INVADE SCREEN FROM THIS DOOR
func __init_auto_destroying():
	
	auto_destroyTimer.one_shot = true
	auto_destroyTimer.wait_time = 2.1
	auto_destroyTimer.connect("timeout", self, "__auto_destroy")
	add_child(auto_destroyTimer)
	auto_destroyTimer.start()
		
	pass
 
 