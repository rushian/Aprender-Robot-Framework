"""
Funcoes de comunicacao e consultas a um banco de dados
"""
import json
import oracledb
import os

def pegar_credenciais_db(json_credencial):
    """
    Rotina para pegar credenciais do banco de dados num arquivo json, para utilizar passe 
    no parametro o nome do arquivo, que deve ficar na pasta TestData
    por exemplo: pegar_credenciais_db('credenciais_db')
    """
    try:
        caminho_credencial_json = "".join(['.', os.sep,'TestData', os.sep,'db',os.sep, json_credencial,'.json'])
    except FileNotFoundError:
        print("Arquivo nao encontrado")

    with open(caminho_credencial_json, 'r') as f:
        dados = json.load(f)

    host =     dados['host']
    port =     dados['port']
    database = dados['db']
    usuario =  dados['usuario']
    senha =    dados['senha']

    return host, port, database, usuario, senha

def inserir_contato(contato, email, cargo):
    """
	Inserir contatos na tabela FESTB750_CONTATO do DB
	"""
    # Configurações de conexão
    host, port, database, username, password = pegar_credenciais_db('credenciais_db')
    dsn = f'{host}/{database}'

    try:
        with oracledb.connect(user=username, password=password, dsn=dsn) as connection:
            with connection.cursor() as cursor:
                sql = "SELECT max(NU_SQNCL_CONTATO) FROM FES.FESTB750_CONTATO"
                for r in cursor.execute(sql):
                    nu_seq = r

        with oracledb.connect(user=username, password=password, dsn=dsn) as connection:
            with connection.cursor() as cursor:
                NU_SQNCL_CONTATO = nu_seq[0] + 1
                NO_CONTATO = contato
                if(email == 'padrao'):
                    DE_EMAIL_CONTATO = f'email{NU_SQNCL_CONTATO}@teste.com'
                else:
                    DE_EMAIL_CONTATO = email
                DE_CARGO_CONTATO = cargo

                sql = "INSERT INTO FES.FESTB750_CONTATO VALUES (:NU_SQNCL_CONTATO, :NO_CONTATO, :DE_EMAIL_CONTATO, :DE_CARGO_CONTATO)"
                cursor.execute(sql, NU_SQNCL_CONTATO=NU_SQNCL_CONTATO, NO_CONTATO=NO_CONTATO,
                                DE_EMAIL_CONTATO=DE_EMAIL_CONTATO,DE_CARGO_CONTATO=DE_CARGO_CONTATO)

            # Confirma a transacao
            connection.commit()
        print("Registro inserido com sucesso!")
        return  "Registro inserido com sucesso!"

    except oracledb.Error as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return  "Erro ao conectar ao banco de dados: {e}"

def listar_contatos():
    """
	Ler contatos da tabela FESTB750_CONTATO do DB
	"""
    # Configurações de conexão
    host, port, database, username, password = pegar_credenciais_db('credenciais_db')
    dsn = f'{host}/{database}'
    contatos = []

    try:
        with oracledb.connect(user=username, password=password, dsn=dsn) as connection:
            with connection.cursor() as cursor:
                sql = "SELECT * FROM FES.FESTB750_CONTATO ORDER BY NU_SQNCL_CONTATO"
                for r in cursor.execute(sql):
                    contatos.append(r)
        print(contatos)
        return  contatos

    except oracledb.Error as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return  "Erro ao conectar ao banco de dados: {e}"
listar_contatos()