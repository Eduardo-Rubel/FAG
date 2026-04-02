import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TelaSelecao(),
  ));
}

Widget buildCirculo(String imagem, double tamanho) {
  return Container(
    height: tamanho,
    width: tamanho,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.grey.shade300, width: 3),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Image.asset("assets/images/$imagem"),
    ),
  );
}

class TelaSelecao extends StatelessWidget {
  const TelaSelecao({super.key});

  void _navegarResultado(BuildContext context, String escolhaUsuario) {
    final opcoes = ["pedra.png", "papel.png", "tesoura.png"];
    final escolhaApp = opcoes[Random().nextInt(opcoes.length)];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaResultado(
          escolhaUsuario: escolhaUsuario,
          escolhaApp: escolhaApp,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedra, Papel, Tesoura", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFFF4848),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          buildCirculo("padrao.png", 150),
          const Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text("Escolha do APP", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => _navegarResultado(context, "pedra.png"),
                child: buildCirculo("pedra.png", 90),
              ),
              GestureDetector(
                onTap: () => _navegarResultado(context, "papel.png"),
                child: buildCirculo("papel.png", 90),
              ),
              GestureDetector(
                onTap: () => _navegarResultado(context, "tesoura.png"),
                child: buildCirculo("tesoura.png", 90),
              ),
            ],
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class TelaResultado extends StatelessWidget {
  final String escolhaUsuario;
  final String escolhaApp;

  const TelaResultado({super.key, required this.escolhaUsuario, required this.escolhaApp});


  Map<String, dynamic> _definirResultado() {
    if (escolhaUsuario == escolhaApp) {
      return {
        "texto": "Empate!",
        "imagem": "assets/images/apertodemaos.png",
      };
    }
    if ((escolhaUsuario == "pedra.png" && escolhaApp == "tesoura.png") ||
        (escolhaUsuario == "papel.png" && escolhaApp == "pedra.png") ||
        (escolhaUsuario == "tesoura.png" && escolhaApp == "papel.png")) {
      return {
        "texto": "Você Ganhou!",
        "imagem": "assets/images/vitoria.png",
      };
    }
    return {
      "texto": "Você Perdeu!",
      "imagem": "assets/images/perder.png",
    };
  }

  @override
  Widget build(BuildContext context) {
    final resultado = _definirResultado();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedra, Papel, Tesoura", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFFF4848),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                buildCirculo(escolhaApp, 130),
                const Text("Escolha do APP", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              children: [
                buildCirculo(escolhaUsuario, 130),
                const Text("Sua Escolha", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              children: [
                Image.asset(resultado["imagem"], height: 80),
                Text(resultado["texto"], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Jogar novamente", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}