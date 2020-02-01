extends KinematicBody2D

const MAX_SPEED = 5

var Move = Vector2()


func _ready():

	pass

func _process(delta):
	
	var Analog = $"../../../UI_screen/Dir_btns/CanvasLayer/Analog"
	# Conversion calculation  
	if (Analog.get("trigered") == true):
		Move = Vector2(cos(-deg2rad(Analog.Angle-90)),sin(-deg2rad(Analog.Angle-90)))*Analog.Strength*MAX_SPEED
		
		rotation = deg2rad(-Analog.Angle - 180)
		
		move_and_collide(Move)
	pass
