from pathlib import Path

from fastapi import FastAPI, HTTPException
from fastapi.responses import FileResponse
from pydantic import BaseModel

# Pasta onde está o main.py (usada para achar Resources/index.html)
PASTA = Path(__file__).parent

# Cria a aplicação. O título aparece na documentação (/docs)
app = FastAPI(title="Minha primeira API")


# Modelo dos dados que a API recebe ao criar/atualizar uma tarefa
class Tarefa(BaseModel):
    titulo: str
    concluida: bool = False


# "Banco de dados" em memória (some quando o servidor reinicia)
tarefas = {}
proximo_id = 1


@app.get("/")
def pagina_inicial():
    """Rota inicial: devolve a página de front (index.html)."""
    return FileResponse(PASTA / "Resources" / "index.html")


@app.get("/status")
def status():
    """Rota para testar se a API está no ar."""
    return {"mensagem": "API funcionando!"}


@app.get("/tarefas")
def listar_tarefas():
    """Lista todas as tarefas."""
    return list(tarefas.values())


@app.get("/tarefas/{id}")
def buscar_tarefa(id: int):
    """Busca uma tarefa pelo id."""
    if id not in tarefas:
        raise HTTPException(status_code=404, detail="Tarefa não encontrada")
    return tarefas[id]


@app.post("/tarefas", status_code=201)
def criar_tarefa(tarefa: Tarefa):
    """Cria uma nova tarefa."""
    global proximo_id
    nova = {"id": proximo_id, "titulo": tarefa.titulo, "concluida": tarefa.concluida}
    tarefas[proximo_id] = nova
    proximo_id += 1
    return nova


@app.put("/tarefas/{id}")
def atualizar_tarefa(id: int, tarefa: Tarefa):
    """Atualiza uma tarefa existente."""
    if id not in tarefas:
        raise HTTPException(status_code=404, detail="Tarefa não encontrada")
    tarefas[id] = {"id": id, "titulo": tarefa.titulo, "concluida": tarefa.concluida}
    return tarefas[id]


@app.delete("/tarefas/{id}", status_code=204)
def remover_tarefa(id: int):
    """Remove uma tarefa."""
    if id not in tarefas:
        raise HTTPException(status_code=404, detail="Tarefa não encontrada")
    del tarefas[id]