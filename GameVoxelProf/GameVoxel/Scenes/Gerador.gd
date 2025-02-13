extends Spatial

onready var movimentado = preload("res://Scenes/Personagem.tscn")
var velocidade := 0.0

func _ready():
	pass

func Inicio(movimentacao:float, tempo:float)->void:
	velocidade = movimentacao
	$Tempo.wait_time = tempo
	
func _on_Tempo_timeout():
	if get_parent().camera - 6 > self.translation.z:
		queue_free()
	else:
		var movimenta = movimentado.instance()	
		get_parent().add_child(movimenta)
		movimenta.global_transform.origin = self.global_transform.origin
		movimenta.Inicio(velocidade)
