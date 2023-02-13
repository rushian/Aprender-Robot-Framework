import pyscreenshot as CapturaTelaCheia
import random

def captura_tela(dir, nome_arquivo):
	imagem = CapturaTelaCheia.grab()
	caminho = dir + nome_arquivo
	imagem.save(caminho, 'png')
	return 'Arquivo criado em: '

def randomize_value(start: int, end: int):
	value = random.randint(start,end)
	print('\nLimite inicial: ',start,' Limite final: ',end,'\nValue',value,flush=True)
	return value

