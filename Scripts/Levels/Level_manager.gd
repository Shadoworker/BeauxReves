extends Node2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
const bro_damage_malus = 5
const boy_damage_malus = 5

var flux = 1

var next_level_timer = Timer.new()

var _timer = Timer.new()
var seconds = 240
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	flux = $Stage/Monsters/entrance.get("flux")
	
	SignalsManager.connect("_s_broDamaged", self , "__bro_damaged")
	SignalsManager.connect("_s_boyDamaged", self , "__boy_damaged")
	SignalsManager.connect("_s_toyRepaired", self , "__toy_repaired")

	SignalsManager.connect("_s_monsterEnded", self , "__goto_next_level")

	
	__countdown()
	__timer()

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if(seconds == 0 or flux == 0):
		var joy = $Stage/Characters/Boy.get("joy")
		
		if(joy <= 50 ):
			
			__game_over()
			
		else:
			
			__init_load_next_level()
			
			pass
		
		pass
	
	pass

func __bro_damaged():
	
	var bro_health = $Stage/Characters/Bro.get("health")
	bro_health -= bro_damage_malus
	$Stage/Characters/Bro.set("health", bro_health)
	$Stage/Characters/Bro.get_node("Anim").play("bro_damaged", -1, 1)
	
	
	
	$UI_screen/Dir_btns/canvas/ui_items/stamina_bar/health_bar.value -= bro_damage_malus 
	
	SignalsManager.emit_signal("_s_toyEnded")
	flux-= 1
	
	__check_monster()
	
	pass


func __boy_damaged():
	
	var boy_fear = $Stage/Characters/Boy.get("fear")
	var boy_joy = $Stage/Characters/Boy.get("joy")
	boy_fear += boy_damage_malus
	boy_joy -= boy_damage_malus
	$Stage/Characters/Boy.set("fear", boy_fear)
	$Stage/Characters/Boy.set("joy", boy_joy)
	$Stage/Characters/Boy.get_node("Anim").play("boy_scared", -1, 1)
	
	
	
	$UI_screen/Dir_btns/canvas/ui_items/feeling_bar/fear_bar.value += boy_damage_malus
	$UI_screen/Dir_btns/canvas/ui_items/feeling_bar/joy_bar.value -= boy_damage_malus
	
	SignalsManager.emit_signal("_s_toyEnded")
	flux-= 1
	
	__check_monster()
	
	pass

func __toy_repaired():
	
	$Stage/Monsters/monsters_items/target_locked_icon.visible = false
	
	var boy_fear = $Stage/Characters/Boy.get("fear")
	var boy_joy = $Stage/Characters/Boy.get("joy")
	boy_fear -= boy_damage_malus
	boy_joy += boy_damage_malus
	$Stage/Characters/Boy.set("fear", boy_fear)
	$Stage/Characters/Boy.set("joy", boy_joy)
	
	
	
	$UI_screen/Dir_btns/canvas/ui_items/feeling_bar/fear_bar.value -= boy_damage_malus
	$UI_screen/Dir_btns/canvas/ui_items/feeling_bar/joy_bar.value += boy_damage_malus
	SignalsManager.emit_signal("_s_toyEnded")
	
	flux-= 1
	__check_monster()
	
	pass
	
func __check_monster():
	
#	if(flux == 0):
#
#		__init_load_next_level()
#
#		pass
	
	pass
	
func __load_next_level():
	
	
	var bro = $Stage/Characters/Bro
	var boy = $Stage/Characters/Boy
	
	var bro_tween = bro.get_node("Tween")
	var boy_tween = boy.get_node("Tween")
	
	var door = $Stage/Monsters/entrance
	
	var bro_pos = bro.global_position
	var boy_pos = boy.global_position
	var door_pos = door.global_position
	
	bro_tween.interpolate_property(bro  , "global_position" , bro_pos, door_pos , 3.0, Tween.TRANS_LINEAR , Tween.EASE_IN )
	bro_tween.start()
	boy_tween.interpolate_property(boy  , "global_position" , boy_pos, door_pos , 3.0, Tween.TRANS_LINEAR , Tween.EASE_IN )
	boy_tween.start()	

	$UI_screen/Dir_btns/canvas/level_transition/Anim.play("fade_out")
	
	
	__init_goto_next_level()
	
	pass
	
func __goto_next_level():
	
	StageManager.goto_scene("res://Scenes/Screens/NextLevel.tscn")
	
	pass
	
	
func __init_load_next_level():

	
	next_level_timer.one_shot = true
	next_level_timer.wait_time = 3
	next_level_timer.connect("timeout", self, "__load_next_level")
	add_child(next_level_timer)
	next_level_timer.start()	

	pass
	
func __init_goto_next_level():

	var goto_timer = Timer.new()
	goto_timer.one_shot = true
	goto_timer.wait_time = 3
	goto_timer.connect("timeout", self, "__goto_next_level")
	add_child(goto_timer)
	goto_timer.start()	

	pass
	

func __countdown():
	
	seconds -= 1
	
	var minutes = seconds / 60
	
	var secs = seconds % 60
	
	var secs_string = str(secs)
	var secs_string2 = secs_string[0] + secs_string[1]
	
	$UI_screen/Dir_btns/canvas/countdown.text = str(minutes , " : " , secs_string2)
	
	pass

	
func __timer():

	_timer.one_shot = false
	_timer.wait_time = 1
	_timer.connect("timeout", self, "__countdown")
	add_child(_timer)
	_timer.start()	

	pass
	
	
func __game_over():
	
	StageManager.goto_scene("res://Scenes/Screens/GameOver.tscn")
	
	pass