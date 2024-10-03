import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/user/service/login_user_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nomeController = TextEditingController();  // Adicionado para nome
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _turmaController = TextEditingController();
  String _userType = 'representative'; // Tipo padrão

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nomeController,  // Campo para o nome
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            TextField(
              controller: _institutionController,
              decoration: InputDecoration(labelText: 'Código da Instituição'),
            ),
            DropdownButton<String>(
              value: _userType,
              items: [
                DropdownMenuItem(value: 'representative', child: Text('Representante')),
                DropdownMenuItem(value: 'admin', child: Text('Admin')),
              ],
              onChanged: (value) {
                setState(() {
                  _userType = value!;
                });
              },
            ),
            if (_userType == 'representative')
              TextField(
                controller: _turmaController,
                decoration: InputDecoration(labelText: 'Abreviação da Turma'),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  String nome = _nomeController.text.trim(); // Nome do usuário
                  String email = _emailController.text.trim();
                  String password = _passwordController.text.trim();
                  String institutionId = _institutionController.text.trim();
                  String turma = _turmaController.text.trim();

                  // Verifica se os campos estão preenchidos
                  if (nome.isEmpty || email.isEmpty || password.isEmpty || institutionId.isEmpty || (_userType == 'representative' && turma.isEmpty)) {
                    print("Por favor, preencha todos os campos.");
                    return;
                  }

                  // Tenta registrar o usuário com o nome incluído
                  await userService.registerWithEmail(
                    nome, 
                    email, 
                    password, 
                    _userType, 
                    institutionId, 
                    turmaId: turma,
                  );

                  if (userService.isLoggedIn) {
                    // Redireciona o usuário para a tela de login após o registro bem-sucedido
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }
                } catch (error) {
                  print("Erro no registro: $error");
                }
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
