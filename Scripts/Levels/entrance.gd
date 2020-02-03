extends Node2D

# Declare member variables here. Examples:
export var spriteLength : int = 4 #NUMBER OF SPRITE ON THE SPRITESHEET

export var flux : int = 5 #Number of monsters which will come from this door
var flux_iterator = 0  # Used to check flux limit
export var speed : int = 2 #Frequency of door invasion 
export var invasion_delay : int = 1 #DELAY BEFORE SCREEN BEING INVADED FROM THIS DOOR
export var boy_nodepath : NodePath
const MONSTER_SCENE = preload("res://Scenes/Components/Monster.tscn")
 
var invasionDelay = Timer.new()
var invasionTimer = Timer.new()
var enemies = []
var monsterIndex = 0 # At least one monster from 
var cell_size
var monsters = 1
var invasion_started = false

var __monster

# Called when the node enters the scene tree for the first time.
func _ready():
	
	SignalsManager.connect("_s_toyEnded" , self, "__kill_monster")
	
	monsters = flux
	#GETTING CELL SIZE FROM SCENE NODE (SCRIPT)
#	cell_size = $"../..".get("cell_size")
	__monster = MONSTER_SCENE.instance()
	
	__invasion_order()
	
	pass # Replace with function body.


func __invade():
	
	cell_size = $"../..".get("cell_size")
	
	var monster = __monster.duplicate(15)
	monster.scale = Vector2(.35, .35)
 
	add_child(monster)
	#A new monster just invaded
	flux_iterator += 1
	
	pass

#ENEMIES GET ORDER TO INVADE SCREEN FROM THIS DOOR
func __invasion_order():
	
	#IF INVADERS BY THIS DOOR
	#JUST FOR READABILITY : BUT STOP METHOD IN _PROCESS CALLBACK ALREADY SOLVE THIS PROBLEM
	if(flux > 0) :
		
		invasion_started = true
		
		invasionDelay.one_shot = true
		invasionDelay.wait_time = invasion_delay
		invasionDelay.connect("timeout", self, "__init_invasion")
		add_child(invasionDelay)
		invasionDelay.start()
		
	pass


func __init_invasion():
	
	
	invasionTimer.one_shot = false
	invasionTimer.wait_time = speed
	invasionTimer.connect("timeout", self, "__invade")
	add_child(invasionTimer)
	invasionTimer.start()
	
	pass
	
func _process(delta):
	
	#Checking invaders limit
	if(flux_iterator == flux):
		#END INVASION FROM THIS DOOR
		invasionTimer.stop()
		
		pass
	
	if(invasion_started == true):
#		print_debug(get_child_count())
		
		if(get_child_count() == 0):
			print_debug("Woooy")
			
		pass
	
	pass

func __kill_monster():
	
#	monsters =- 1
	
	pass