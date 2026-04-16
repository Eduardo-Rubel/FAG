import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'tela_confirmacao.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final FocusNode _nomeFocus = FocusNode();
  final FocusNode _idadeFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  String? _sexoSelecionado;
  bool _aceitouTermos = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _idadeController.dispose();
    _emailController.dispose();
    _nomeFocus.dispose();
    _idadeFocus.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(mensagem), backgroundColor: Colors.redAccent),
      );
  }

  void _cadastrar() {
    final nome = _nomeController.text.trim();
    final idadeTexto = _idadeController.text.trim();
    final email = _emailController.text.trim();

    if (nome.isEmpty) {
      _mostrarErro('Informe o nome.');
      return;
    }

    if (idadeTexto.isEmpty) {
      _mostrarErro('Informe a idade.');
      return;
    }

    int idade;
    try {
      idade = int.parse(idadeTexto);
    } catch (_) {
      _mostrarErro('A idade deve ser um numero valido.');
      return;
    }

    if (idade < 18) {
      _mostrarErro('A idade deve ser maior ou igual a 18.');
      return;
    }

    if (email.isEmpty) {
      _mostrarErro('Informe o email.');
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      _mostrarErro('Informe um email valido.');
      return;
    }

    if (_sexoSelecionado == null) {
      _mostrarErro('Selecione o sexo.');
      return;
    }

    if (!_aceitouTermos) {
      _mostrarErro('Voce precisa aceitar os termos de uso.');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaConfirmacao(
          nome: nome,
          idade: idade,
          email: email,
          sexo: _sexoSelecionado!,
          aceitouTermos: _aceitouTermos,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Usuario')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: 380,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
                side: BorderSide(color: theme.colorScheme.outlineVariant),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Cadastro',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Preencha os dados para continuar.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _nomeController,
                      focusNode: _nomeFocus,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => FocusScope.of(context).requestFocus(
                        _idadeFocus,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        hintText: 'Digite seu nome',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _idadeController,
                      focusNode: _idadeFocus,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => FocusScope.of(context).requestFocus(
                        _emailFocus,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Idade',
                        hintText: 'Digite sua idade',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      focusNode: _emailFocus,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _cadastrar(),
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Digite seu email',
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _sexoSelecionado,
                      decoration: const InputDecoration(labelText: 'Sexo'),
                      hint: const Text('Selecione o sexo'),
                      items: const [
                        DropdownMenuItem(
                          value: 'Masculino',
                          child: Text('Masculino'),
                        ),
                        DropdownMenuItem(
                          value: 'Feminino',
                          child: Text('Feminino'),
                        ),
                        DropdownMenuItem(value: 'Outro', child: Text('Outro')),
                      ],
                      onChanged: (valor) {
                        setState(() {
                          _sexoSelecionado = valor;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    CheckboxListTile(
                      value: _aceitouTermos,
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text('Aceito os termos de uso'),
                      onChanged: (valor) {
                        setState(() {
                          _aceitouTermos = valor ?? false;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _cadastrar,
                      child: const Text(
                        'Cadastrar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
