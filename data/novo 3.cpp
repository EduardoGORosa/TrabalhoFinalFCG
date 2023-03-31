	// Entrada: Um conjunto U e um conjunto de subconjuntos S de U
	// Saída: "Verdadeiro" se existe um conjunto T de no máximo k subconjuntos de S que cobre todos os elementos de U, "Falso" caso contrário.

	elementos_nao_cobertos = U

	if k = 0, retorna "Verdadeiro"

	para i de 1 até k:
		t = vazio
		max_intersecao = 0
		
		para cada subconjunto s em S:
			intersecao = intersecao_conjuntos(s, elementos_nao_cobertos)
			if |intersecao| > max_intersecao:
				max_intersecao = |intersecao|
				t = s
			end if
		end for
		
		Se t = vazio, retorna "Falso"
		
		elementos_nao_cobertos = diferenca(elementos_nao_cobertos,t)
		
		Se elementos_nao_cobertos = vazio, retorna "Verdadeiro"
		
	end for

	retorna "Falso"