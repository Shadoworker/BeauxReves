extends Area2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var dir : String = "TOP"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_DOWN_body_entered(body: PhysicsBody2D) -> void:
	SignalsManager.emit_signal("_s_broDirection" , dir)
	pass # Replace with function body.
