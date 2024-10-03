import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/user/service/login_user_service.dart';
import 'home_screen.dart';
import 'register_screen.dart'; // Certifique-se de importar a tela de registro

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await userService.loginWithEmail(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                );
                if (userService.isLoggedIn) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()), // Navegar para a HomeScreen após o login
                  );
                }
              },
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            // Botão de Cadastrar
            TextButton(
              onPressed: () {
                // Redirecionar para a tela de cadastro
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text('Cadastrar-se'),
            ),
          ],
        ),
      ),
    );
  }
}
