"""
Funcoes gerais em python para complementar a acao do Robot
"""

import json
import openpyxl 
from openpyxl import Workbook
from openpyxl.utils import get_column_letter
from openpyxl.styles import Alignment, Border, Side, Font
import pandas as pd
import platform
import pyscreenshot as CapturaTelaCheia
import random
import xlrd
import docx2txt
from datetime import datetime

def verificar_ambiente():
    """
    Verificar se o python está rodando normalmente, para testar no arquivo geral.py,
    descomente o print(verifica_ambiente)
    """
    versao = platform.python_version()
    sistema = platform.system()
    maquina = platform.machine()
    print('Python executando corretamente')
    print('Versao do python: ', versao)
    print('Sistema: ', sistema)
    print('Maquina: ', maquina)
    numero1 = 5
    numero2 = 3
    print(f'{numero1} + {numero2} = ', str((numero1+numero2)))
    return  versao, sistema, maquina


def ler_qtde_linhas_na_planilha(fileName, sheetname) : 
    workbook = xlrd.open_workbook(fileName)
    worksheet = workbook.sheet_by_name(sheetname)

    rowEndIndex = worksheet.nrows - 1
    colEndIndex = worksheet.ncols - 1 
    print (rowEndIndex)
    return rowEndIndex
#ler_qtde_linhas_na_planilha('C:\\Users\\f675422\\Downloads\\excel (1).xls', 'Sheet0') 

def ler_docx(fileName) : 
    my_text = docx2txt.process(fileName)
    print (my_text)
    return my_text
#ler_docx('C:\\Users\\f675422\\Downloads\\teste.docx')

def randomize_value(start: int, end: int):
	"""
	Definir um numero aleatorio no range entre o valor inicial e final
	"""
	value = random.randint(start,end)
	print('\nLimite inicial:  ',start,' Limite final:  ',end,'\nValor: ',value,flush=True)
	return value
#randomize_value(1,8)

def converter_xls_para_json(caminho_arquivo_xls, caminho_resultado_json):
	"""
	Rotina para gerar json de colunas simples
	"""
	# Carrega o arquivo XLS usando pandas
	data_frame = pd.read_excel(caminho_arquivo_xls) 
	# Converte o DataFrame em uma representação JSON
	dados_pro_json = data_frame.to_json(orient='records') 
    # Obter a data atual
	data_atual = datetime.now().strftime("%d-%m-%Y_%H-%M")
    # Adicionar a data atual ao nome do arquivo
	caminho_resultado_json_com_data = caminho_resultado_json.replace('.json', f'_{data_atual}.json')
	# Converter a string json para um objeto Python
	objeto_json = json.loads(dados_pro_json)
    # Escreve o JSON em um arquivo
	with open(caminho_resultado_json_com_data, 'w') as arquivo_json:
		json.dump(objeto_json,arquivo_json,indent=4)
	print('Arquivo salvo em: ', caminho_resultado_json_com_data)
# Exemplo de uso
# caminho_arquivo_xls = "".join(['TestData', os.sep, 'result1.xlsx'])
# caminho_resultado_json = "".join(['TestData', os.sep, 'massa_simples.json'])
# converter_xls_para_json(caminho_arquivo_xls, caminho_resultado_json)

def converter_xlsx_com_subnivel_para_json(caminho_arquivo_xls, caminho_resultado_json):
    """
    Rotina para gerar json com cabeçalhos encadeados hierarquicamente
    """
    # Carrega o arquivo XLSX usando o openpyxl
    workbook = openpyxl.load_workbook(caminho_arquivo_xls)
    # Seleciona a primeira planilha
    sheet = workbook.active
    # Obtém os valores das células e seus rótulos
    data = []
    for row in sheet.iter_rows(min_row=3,values_only=True):
        data.append(row)
    # Obtém os títulos das colunas
    headers = data.pop(0)
   # Cria um dicionário com os dados
    json_data = {
        "paciente": []
    }
	# Adiciona as linhas da planilha
    for row in data:
        paciente = {
            "dados_pessoais": {
                "nome": row[0],
                "idade": row[1]
            },
            "dados_clinicos": {
                "data_consulta": row[2].strftime("%Y-%m-%d"),
                "medico": row[3],
                "receituario": row[4]
            }
        }
        json_data["paciente"].append(paciente)

    data_atual = datetime.now().strftime("%d-%m-%Y_%H-%M")
    # Adicionar a data atual ao nome do arquivo
    caminho_resultado_json_com_data = caminho_resultado_json.replace('.json', f'_{data_atual}.json')

    # Cria o arquivo JSON com os dados convertidos
    with open(caminho_resultado_json_com_data, 'w') as file:
        json.dump(json_data, file, indent=4)

    print('Arquivo salvo em: ', caminho_resultado_json_com_data)
# Exemplo de uso
# caminho_arquivo_xls = "".join(['TestData', os.sep, 'massa_pacientes.xlsx'])
# caminho_resultado_json = "".join(['TestData', os.sep, 'massa_pacientes.json'])
# converter_xlsx_com_subnivel_para_json(caminho_arquivo_xls, caminho_resultado_json)

def convert_json_to_xlsx(json_file_path, xlsx_file_path):
    """
    Rotina para gerar xlsx a partir do json
    """
    # Carrega o arquivo JSON
    with open(json_file_path, 'r', encoding='utf-8') as file:
        json_data = json.load(file)

    # Extrai os dados do JSON
    dados = []
    for paciente in json_data['paciente']:
        dados.append([
            paciente['dados_pessoais']['nome'],
            paciente['dados_pessoais']['idade'],
            paciente['dados_clinicos']['data_consulta'],
            paciente['dados_clinicos']['medico'],
            paciente['dados_clinicos']['receituario'],
        ])

    colunas = ['Nome', 'Idade', 'Data da Consulta', 'Médico', 'Receituário']

    # Cria o arquivo XLSX usando openpyxl
    book = Workbook()
    sheet = book.active

    # Cabeçalhos (linhas 1 a 3)
    sheet.cell(row=1, column=1).value = 'Paciente'
    sheet.cell(row=2, column=1).value = 'Dados Pessoais'
    sheet.cell(row=2, column=3).value = 'Dados Clinicos'
    for col_idx, nome_coluna in enumerate(colunas, start=1):
        sheet.cell(row=3, column=col_idx).value = nome_coluna

    # Dados (a partir da linha 4)
    for row_idx, linha in enumerate(dados, start=4):
        for col_idx, valor in enumerate(linha, start=1):
            sheet.cell(row=row_idx, column=col_idx).value = valor

    # Formatação dos cabeçalhos
    borda = Border(
        left=Side(style='thin'), right=Side(style='thin'),
        top=Side(style='thin'), bottom=Side(style='thin')
    )
    for row in sheet.iter_rows(min_row=1, max_row=3, min_col=1, max_col=5):
        for cell in row:
            cell.font = Font(bold=True)
            cell.alignment = Alignment(horizontal='center', vertical='center')
            cell.border = borda

    # Ajusta a largura das colunas (considera os títulos da linha 3 e os dados)
    for column in sheet.iter_cols(min_row=3, max_col=5):
        max_length = max(len(str(cell.value or '')) for cell in column)
        letra = get_column_letter(column[0].column)
        sheet.column_dimensions[letra].width = max_length + 2

    # Mescla as células nas linhas 1 e 2
    sheet.merge_cells('A1:E1')
    sheet.merge_cells('A2:B2')
    sheet.merge_cells('C2:E2')

    # Salva o arquivo XLSX
    book.save(xlsx_file_path)

    print('Arquivo salvo em: ', xlsx_file_path)
# Exemplo de uso
# json_file_path = "".join(['TestData', os.sep, 'pacientes.json'])
# xlsx_file_path =  "".join(['TestData', os.sep, 'result1.xlsx'])
# convert_json_to_xlsx(json_file_path, xlsx_file_path)

def captura_tela(dir, nome_arquivo):
	"""
	Captura de tela cheia para obter a barra de tarefas com data e hora 
	* Se a janela atual não for o navegador do teste, o print ira capturar o que estiver na tela
	"""
	imagem = CapturaTelaCheia.grab()
	caminho = dir + nome_arquivo 
	imagem.save(caminho, 'png')
	return 'Evidencia criada em: ' + caminho.replace('\\\\','\\')
#captura_tela('Evidencias\\14-06-2023\\Compra de 3 produtos com sucesso\\','teste1.png')

def pegar_id(elemento):
    """
    Gerar substring do id para usar em click javascript
    """
    inicio = elemento.index('id="')+4
    fim = elemento.index('"]')
    id = elemento[inicio:fim]

    return id
#print(pegar_id('//*[@id="campo-com-valor"]'))

