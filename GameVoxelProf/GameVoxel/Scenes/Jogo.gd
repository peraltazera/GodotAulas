extends Spatial

enum {nada = -1, areia = 0, pista = 0, rua = 0}

var novaFaixa = 40
var velhaFaixa = -5
var camera = 0	

func _ready():
	RedesenharCenario()

func RedesenharCenario():
	$Cenario.clear()
	for z in range(velhaFaixa, novaFaixa+1):
		var i
		
		if z <= 5:
			i = areia
		else:
			var anterior = $Cenario.get_cell_item(0, 0, z-1)
			i = ProximoDoCenario(anterior)
		
		for x in range(-1, 1):
			$Cenario.set_cell_item(x, 0, z, i)
			
		if i == areia:	
			AdicionarObstaculos(z)

		if i in [rua, pista]:
			AdicionarObstaculosMoveis(z)
	
func ProximoDoCenario(anterior):
	var i
		
	match anterior:
		areia:
			i = SortearCenario([areia, pista, rua])
		rua:
			i = areia
		pista:
			i = SortearCenario([pista, rua])
		nada:
			i = areia
		
	if i == areia:
		AdicionarObstaculos(novaFaixa)

	if i in [rua, pista]:
		AdicionarObstaculosMoveis(novaFaixa)

	return i

func SortearCenario(lista):
	randomize()
	return lista[randi()%lista.size()]
	
func AdicionarFaixa():
	var anterior = $Cenario.get_cell_item(0, 0, novaFaixa)
	var i = ProximoDoCenario(anterior)
	novaFaixa+=1
	
	for x in range(-1, 1):
		$Cenario.set_cell_item(x, 0, novaFaixa, i)
		
onready var gerador = preload("res://Gerador.tscn")
		

func AdicionarObstaculos(linha):
	$Obstaculos.set_cell_item(-8, 0, linha, randi()%5)
	$Obstaculos.set_cell_item(7, 0, linha, randi()%5)
	
	for x in range(-7, 7):
		if randi()%10 < 5:
			$Obstaculos.set_cell_item(x, 0, linha, randi()%5)
			
func DeletarFaixa():
	for x in range(-1, 1):
		$Cenario.set_cell_item(x, 0, velhaFaixa, -1)
	
	for x in range(-8, 8):
		if $Obstaculos.get_cell_item(x, 0, velhaFaixa) != -1:
			$Obstaculos.set_cell_item(x, 0, velhaFaixa, -1)
			yield(get_tree(), "idle_frame")				
	velhaFaixa+=1
	
func AdicionarObstaculosMoveis(linha):
	var lado = SortearCenario([-1, 1])
	var tempo = rand_range(2.0, 5.0)
	var velocidade = rand_range(10.0, 15.0) * - lado
	var gerarMovimentados = gerador.instance()
	
	add_child(gerarMovimentados)
	gerarMovimentados.translation = Vector3(13 * lado, 2, (linha * 2) + 1)
