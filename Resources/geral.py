import pyscreenshot as CapturaTelaCheia

def captura_tela(dir, nome_arquivo):
	imagem = CapturaTelaCheia.grab()
	caminho = dir + nome_arquivo
	imagem.save(caminho, 'png')
	print('Arquivo criado em: ', caminho)
	return 'Arquivo criado em: ' + caminho
