extends Spatial

enum {nada = -1, areia = 1, pista = 2, rua = 2}

var novaFaixa = 40
var velhaFaixa = -5

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

