"""
Tentativa de configurar o vs code pra rodar os testes python
"""
from geral import verificar_ambiente

def test_verificar_ambiente():
    assert verificar_ambiente() == ('3.11.0', 'Windows', 'AMD64')

