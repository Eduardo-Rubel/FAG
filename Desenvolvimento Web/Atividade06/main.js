const tarefaIn = document.getElementById("tarefaIn");
const addBtn = document.getElementById("addBtn");
const tarefaList = document.getElementById("tarefasList");

console.log(tarefaIn, addBtn, tarefaList);

addBtn.addEventListener("click", function() {
    const textoTarefa = tarefaIn.value.trim();
    if (textoTarefa === "") {
        alert("Digite uma tarefa válida.");
        return;
    }

    const novaTarefa = document.createElement("li");
    novaTarefa.textContent = textoTarefa;
    
    tarefaList.appendChild(novaTarefa);
    tarefaIn.value = "";
    tarefaIn.focus();
});


tarefaList.addEventListener("click", function(event) {
    const itemremove = event.target.closest("li");

    if (itemremove) {
        itemremove.remove()
    }
});
