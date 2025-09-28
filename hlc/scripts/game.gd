extends Node2D

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	var barrier_width = $world_barrier/box_A.get_shape().get_rect().size.x
	var player_width = $Player/col_box_A.get_shape().get_rect().size.x
	$world_barrier.position.x = $Player.position.x - (barrier_width - player_width) / 2
	var bg_width = $bg.get_rect().size.x
	$bg.position.x = $Player.position.x - (bg_width - player_width) / 2
func _player_fell(body: Node2D) -> void:
	Globals.hearts -= 1
	$Player.position.x = Globals.checkpoints[max(len(Globals.checkpoints) - 1, 0)].x
	$Player.position.y = -100
