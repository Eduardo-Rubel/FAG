import 'package:flutter/material.dart';

class TelaConfirmacao extends StatelessWidget {
  final String nome;
  final int idade;
  final String email;
  final String sexo;
  final bool aceitouTermos;

  const TelaConfirmacao({
    super.key,
    required this.nome,
    required this.idade,
    required this.email,
    required this.sexo,
    required this.aceitouTermos,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Confirmacao')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: 380,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(color: theme.colorScheme.outlineVariant),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Dados cadastrados',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Nome: $nome',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('Idade: $idade', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    Text('Email: $email', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    Text('Sexo: $sexo', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    Text(
                      'Termos aceitos: ${aceitouTermos ? 'Sim' : 'Nao'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Voltar'),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Editar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
