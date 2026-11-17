"""
Funcoes de comunicacao e consultas a um banco de dados PostgreSQL
"""
import json
import os
from contextlib import closing

import psycopg2


def pegar_credenciais_db(json_credencial):
    """
    Le as credenciais do banco em TestData/db/<json_credencial>.json
    Exemplo: pegar_credenciais_db('credenciais_db')
    """
    caminho = os.path.join('.', 'TestData', 'db', f'{json_credencial}.json')

    try:
        with open(caminho, 'r', encoding='utf-8') as f:
            dados = json.load(f)
    except FileNotFoundError:
        raise FileNotFoundError(f'Arquivo de credenciais nao encontrado: {caminho}')

    return (dados['host'], dados['port'], dados['db'],
            dados['usuario'], dados['senha'])


def _conectar(json_credencial='credenciais_db'):
    """Abre uma conexao com o banco usando o arquivo de credenciais."""
    host, port, database, usuario, senha = pegar_credenciais_db(json_credencial)
    return psycopg2.connect(host=host, port=port, dbname=database,
                            user=usuario, password=senha)


def inserir_contato(contato, email, cargo):
    """
    Insere um contato na tabela fes.festb750_contato.
    Se email == 'padrao', gera 'email<N>@teste.com'.
    """
    # closing() fecha a conexao; "with conn" faz commit (ou rollback em caso de erro)
    with closing(_conectar()) as conn, conn, conn.cursor() as cursor:
        # Bloqueia escritas concorrentes na tabela ate o fim da transacao,
        # evitando que dois testes gerem o mesmo MAX + 1
        cursor.execute("LOCK TABLE fes.festb750_contato IN SHARE ROW EXCLUSIVE MODE")

        cursor.execute("SELECT COALESCE(MAX(nu_sqncl_contato), 0) FROM fes.festb750_contato")
        nu_sqncl = cursor.fetchone()[0] + 1

        if email == 'padrao':
            email = f'email{nu_sqncl}@teste.com'

        cursor.execute(
            """
            INSERT INTO fes.festb750_contato
                (nu_sqncl_contato, no_contato, de_email_contato, de_cargo_contato)
            VALUES (%s, %s, %s, %s)
            """,
            (nu_sqncl, contato, email, cargo)
        )

    mensagem = f'Registro {nu_sqncl} inserido com sucesso!'
    print(mensagem)
    return mensagem


def listar_contatos():
    """Retorna todos os contatos da tabela fes.festb750_contato."""
    with closing(_conectar()) as conn, conn.cursor() as cursor:
        cursor.execute("SELECT * FROM fes.festb750_contato ORDER BY nu_sqncl_contato")
        contatos = cursor.fetchall()

    print(contatos)
    return contatos


if __name__ == '__main__':
    listar_contatos()