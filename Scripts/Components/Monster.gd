extends RigidBody2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):


	 
	pass


func _on_Monster_body_entered(body: Node) -> void:
	print_debug("Yay !")
	pass # Replace with function body.
