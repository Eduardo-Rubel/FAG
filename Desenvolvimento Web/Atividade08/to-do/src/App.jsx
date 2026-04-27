import { useState } from 'react'

function App() {
  const [tarefas, setTarefas] = useState([])
  const [texto, setTexto] = useState('')

  function adicionarTarefa(event) {
    event.preventDefault()

    if (texto.trim() === '') {
      return
    }

    const novaTarefa = {
      id: Date.now(),
      text: texto,
    }

    setTarefas([...tarefas, novaTarefa])
    setTexto('')
  }

  function removerTarefa(id) {
    const novasTarefas = tarefas.filter((tarefa) => tarefa.id !== id)
    setTarefas(novasTarefas)
  }

  return (
    <div className="container">
      <h1>To-Do List</h1>

      <form onSubmit={adicionarTarefa}>
        <input
          type="text"
          value={texto}
          onChange={(event) => setTexto(event.target.value)}
          placeholder="Digite uma tarefa"
        />
        <button type="submit">Adicionar</button>
      </form>

      <ul>
        {tarefas.map((tarefa) => (
          <li key={tarefa.id}>
            <span>{tarefa.text}</span>
            <button type="button" onClick={() => removerTarefa(tarefa.id)}>
              Remover
            </button>
          </li>
        ))}
      </ul>
    </div>
  )
}

export default App
