extends Area

var direcao = Vector3.ZERO

func _physics_process(delta):
	movimentacao()

func movimentacao():
	direcao = Vector3.ZERO
	
	if Input.is_action_pressed("ui_up"):
		if not $Frente.is_colliding() : direcao = Vector3.BACK
	elif Input.is_action_pressed("ui_down"):
		if not $Costas.is_colliding() : direcao = -Vector3.BACK
	elif Input.is_action_pressed("ui_right"):
		if not $Direita.is_colliding() : direcao = Vector3.LEFT
	elif Input.is_action_pressed("ui_left"):
		if not $Esquerda.is_colliding() : direcao = Vector3.RIGHT
	
