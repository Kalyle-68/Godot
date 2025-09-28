extends Node2D

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	if $anim.frame == 3:
		$anim.pause()

func _set_checkpoint(body: Node2D) -> void:
	if body.name == "Player":
		var point = Vector2(self.position.x + 32, self.position.y + 32)
		if not (point in Globals.checkpoints):
			Globals.checkpoints.append(point)
			$anim.play("grow")
