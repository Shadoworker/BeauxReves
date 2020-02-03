extends KinematicBody2D

const MAX_SPEED = 1.0
const REPAIRER_SCENE = preload("res://Scenes/Components/Repairer.tscn")

export var health : int = 100

var repairer 
var Move = Vector2()
var raycast : RayCast2D
var target_locker : Sprite
var target_locked = false

func _ready():
	
	SignalsManager.connect("_s_broDirection" , self, "__change_dir")
	
	raycast = $RayCast2D
	
	target_locker = $"../../Monsters/monsters_items/target_locked_icon"
	
	repairer = REPAIRER_SCENE.instance()

	
	pass

func _physics_process(delta):
	
	
	if(Input.is_mouse_button_pressed(BUTTON_LEFT)):
		
		__Repair()
		
		pass
	
	
	var Analog = $"../../../UI_screen/Dir_btns/canvas/Analog"
	# Conversion calculation  
	if (Analog.get("trigered") == true):
		Move = Vector2(cos(-deg2rad(Analog.Angle-90)),sin(-deg2rad(Analog.Angle-90)))*Analog.Strength*MAX_SPEED
		
		var angle = -Analog.Angle 
#		rotation = deg2rad(angle - 180)
		$RayCast2D.rotation = deg2rad(angle)
		
		move_and_collide(Move)
	
		
		
		
		if(raycast.is_colliding()):
			
			var collider = raycast.get_collider()
			if(collider.is_in_group("monsters")):
#				print_debug("Woooy Mboot")
				# SET CIRCLE TARGET FOLLOWING CURRENT ONE 
				var monster = collider
				target_locked = true
				target_locker.visible = true
				target_locker.global_position = monster.global_position
				pass
		else:
			target_locker.visible = false
			target_locked = false
			
		pass
	
	pass
		
	pass



#SETS HERO SIDE CHANGE MOTION
func __change_dir(dir):
	__dir_motion(dir)
	pass


func __dir_motion(dir):
	
#	self.get_node("Anim").play(str("walk_", dir), -1 , 1)
	if(dir == "IDLE"):
#		stop all player animation
		$Anim.stop()
		
	else:
		$Anim.play(str("walk_" , dir) , -1 , 1)
	
	pass

func _on_Repair_btn_button_down():
	
	$"../../../UI_screen/Dir_btns/canvas/Repair_btn/Anim".play("repairer", -1, 2)
	
	if target_locked == true :
		
		# FLUUSH ANIMATION IN monster's direction : which is now target_locker dir 
		
		var new_repairer = repairer.duplicate(15)
		
		$RayCast2D/flush_container.add_child(new_repairer)
		
		var tween = new_repairer.get_node("Tween")
		
		var angle = $RayCast2D/flush_container.global_position.angle_to(target_locker.global_position)
		
		new_repairer.rotation = rad2deg(angle)
		
		tween.interpolate_property(new_repairer  , "global_position" , $RayCast2D/flush_container.global_position, target_locker.global_position , 2.0, Tween.TRANS_LINEAR , Tween.EASE_IN )
		tween.start()
		
		pass
	
	pass # Replace with function body.


func __Repair():
	
	$"../../../UI_screen/Dir_btns/canvas/Repair_btn/Anim".play("repairer", -1, 2)
	
	if target_locked == true :
		
		# FLUUSH ANIMATION IN monster's direction : which is now target_locker dir 
		
		var new_repairer = repairer.duplicate(15)
		
		$RayCast2D/flush_container.add_child(new_repairer)
		
		var tween = new_repairer.get_node("Tween")
		
		var angle = $RayCast2D/flush_container.global_position.angle_to(target_locker.global_position)
		
		new_repairer.rotation = rad2deg(angle)
		
		tween.interpolate_property(new_repairer  , "global_position" , $RayCast2D/flush_container.global_position, target_locker.global_position , 2.0, Tween.TRANS_LINEAR , Tween.EASE_IN )
		tween.start()
		
		pass
	
	pass # Replace with function body.
