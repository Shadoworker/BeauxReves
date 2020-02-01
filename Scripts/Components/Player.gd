extends KinematicBody2D

const MAX_SPEED = 5
const REPAIRER_SCENE = preload("res://Scenes/Components/Repairer.tscn")

var repairer 
var Move = Vector2()
var raycast : RayCast2D
var target_locker : Sprite
var target_locked = false

func _ready():
	
	raycast = $RayCast2D
	
	target_locker = $"../../Monsters/monsters_items/target_locked_icon"
	
	repairer = REPAIRER_SCENE.instance()

	
	pass

func _physics_process(delta):
	
	var Analog = $"../../../UI_screen/Dir_btns/CanvasLayer/Analog"
	# Conversion calculation  
	if (Analog.get("trigered") == true):
		Move = Vector2(cos(-deg2rad(Analog.Angle-90)),sin(-deg2rad(Analog.Angle-90)))*Analog.Strength*MAX_SPEED
		
		rotation = deg2rad(-Analog.Angle - 180)
		
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


func _on_Repair_btn_button_down():
	
	if target_locked == true :
		
		# FLUUSH ANIMATION IN monster's direction : which is now target_locker dir 
		
		var new_repairer = repairer.duplicate(15)
		
		$flush_container.add_child(new_repairer)
		
		var tween = new_repairer.get_node("Tween")
		
		tween.interpolate_property(new_repairer  , "global_position" , $flush_container.global_position , target_locker.global_position , 2.0, Tween.TRANS_LINEAR , Tween.EASE_IN )
		tween.start()
		
		pass
	
	pass # Replace with function body.
