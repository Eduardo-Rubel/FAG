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
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Usuario')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: 380,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Preencha os campos abaixo',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _nomeController,
                  focusNode: _nomeFocus,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => FocusScope.of(context).requestFocus(
                    _idadeFocus,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    hintText: 'Digite seu nome',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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
                  decoration: InputDecoration(
                    labelText: 'Idade',
                    hintText: 'Digite sua idade',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  focusNode: _emailFocus,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _cadastrar(),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Digite seu email',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _sexoSelecionado,
                  decoration: InputDecoration(
                    labelText: 'Sexo',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
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
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CheckboxListTile(
                    value: _aceitouTermos,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Aceito os termos de uso'),
                    onChanged: (valor) {
                      setState(() {
                        _aceitouTermos = valor ?? false;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  onPressed: _cadastrar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
