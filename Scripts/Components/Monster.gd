extends RigidBody2D

# Declare member variables here. Examples:

#-----------CONSTANTS---------------------
const DURATION_BASE = 50

#-----------EXPORTED VARIABLES---------------------
 
export var minionized = false
#-----------GLOBAL VARIABLES---------------------

var monster_weapon : RayCast2D

var monster_tween : Tween

var bro : Node2D

var boy : Node2D

var fake_inbs : Node2D

var random_inb : Node2D

var inb_reached = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	monster_weapon = $Monster_weapon
	
	monster_tween = $Tween
	
	bro = $"../../../Characters/Bro"
	boy = $"../../../Characters/Boy"
	fake_inbs = $"../../fake_inbetweens"
	
	var random_inb_index = randi() % fake_inbs.get_child_count()
	
	random_inb = fake_inbs.get_child(random_inb_index)
	
	__move_to(random_inb)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
		
	if(not inb_reached):
		if(self.global_position >= random_inb.global_position):
			
			inb_reached = true
			__move_to(boy)
			pass
	
	if(minionized == true):
		monster_tween.stop(self)
		inb_reached = true
		minionized = false
		__add_to_minions()
		pass
		
	 
	if(monster_weapon.is_colliding()):
		
		var collider = monster_weapon.get_collider()
		if(collider.is_in_group("bro")):
			SignalsManager.emit_signal("_s_broDamaged")
#			print_debug("Bro touched")
			queue_free()
			
#			collider.get_node("Anim").play("monster_fade_in" , -1, 0.5)
	
		if(collider.is_in_group("boy")):
			SignalsManager.emit_signal("_s_boyDamaged")
#			print_debug("Boy touched")

			queue_free()

	
	pass

func __move_to(target):
	
	var self_pos = self.global_position
	var target_pos = target.global_position
	var distance = self_pos.distance_to(target_pos)
	var duration = distance / DURATION_BASE
	monster_tween.interpolate_property(self  , "global_position" , self_pos , target_pos , duration, Tween.TRANS_LINEAR , Tween.EASE_IN )
	monster_tween.start()
	
	
	pass

func __add_to_minions():

	var self_pos = self.global_position
	var target_pos = $"../../../../UI_screen/Dir_btns/canvas/minions_box".global_position
	var distance = self_pos.distance_to(target_pos)
	monster_tween.interpolate_property(self  , "global_position" , self_pos , target_pos , 1.8, Tween.TRANS_LINEAR , Tween.EASE_IN )
	monster_tween.start()
	
	var monster_tween_scale = self.get_node("Tween")
	monster_tween_scale.interpolate_property(self  , "scale" , self.global_scale , Vector2(0.1 , 0.1) , 1.8, Tween.TRANS_LINEAR , Tween.EASE_IN )
	monster_tween_scale.start()
	
	self.get_node("Anim").play("monster_fade_in" , -1, 1.5)
	
	
	pass