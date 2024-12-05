extends Area

var direcao = Vector3.ZERO

func _physics_process(_delta):
	movimentacao()
	
func movimentacao():
	direcao = Vector3.ZERO
	
	if Input.is_action_pressed("ui_up"):
		if not $Frente.is_colliding() : direcao = Vector3.BACK
		
	elif Input.is_action_pressed("ui_left"):
		if not $Esquerda.is_colliding() : direcao = Vector3.RIGHT
			
	elif Input.is_action_pressed("ui_right"):
		if not $Direita.is_colliding() : direcao = Vector3.LEFT
		
	elif Input.is_action_pressed("ui_down"):
		if not $Costas.is_colliding() : direcao = -Vector3.BACK
		
	var posicaoInicial = self.translation
	var posicaoFinal = posicaoInicial + (direcao*2)
	$Movimentacao.interpolate_property(self, "translation", posicaoInicial, posicaoFinal, 0.1, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Movimentacao.start()
