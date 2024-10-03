import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/user/service/login_user_service.dart';
import 'login_screen.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);

    // Log para verificar o estado do usuário
    print('Usuário é guest? ${userService.isGuest}');
    print('Tipo de usuário: ${userService.userType}');
    print('Usuário está logado? ${userService.isLoggedIn}');

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (userService.isGuest) ...[
              // Perfil de Convidado
              CircleAvatar(
                radius: 50,
                child: Icon(Icons.person_outline, size: 50),
              ),
              SizedBox(height: 20),
              Text('Tipo de Conta: Convidado'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Redirecionar para a tela de login
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Cor do botão
                  foregroundColor: Colors.white, // Cor do texto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text('Conectar', style: TextStyle(fontSize: 18)),
              ),
            ] else if (userService.isAdmin) ...[
              // Perfil de Admin
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(userService.userModel?.profilePhoto ?? ''),
              ),
              SizedBox(height: 20),
              Text(userService.userModel?.email ?? 'Admin'),
              Text('Função: Professor'),
              Text('Tipo de Conta: Administrador'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Lógica para mudar senha
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Cor do botão
                  foregroundColor: Colors.white, // Cor do texto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text('Mudar Senha', style: TextStyle(fontSize: 18)),
              ),
              ElevatedButton(
                onPressed: () async {
                  await userService.logOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Cor do botão de logout
                  foregroundColor: Colors.white, // Cor do texto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text('Desconectar', style: TextStyle(fontSize: 18)),
              ),
            ] else if (userService.isRepresentative) ...[
              // Perfil de Representante
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(userService.userModel?.profilePhoto ?? ''),
              ),
              SizedBox(height: 20),
              Text(userService.userModel?.email ?? 'Representante'),
              Text('Turma: ${userService.userModel?.turmaId ?? 'N/A'}'),
              Text('Nome da Turma: Computaria'),
              Text('Tipo de Conta: Representante'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Lógica para mudar senha
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Cor do botão
                  foregroundColor: Colors.white, // Cor do texto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text('Mudar Senha', style: TextStyle(fontSize: 18)),
              ),
              ElevatedButton(
                onPressed: () {
                  // Lógica para editar turma
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Cor do botão
                  foregroundColor: Colors.white, // Cor do texto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text('Editar Turma', style: TextStyle(fontSize: 18)),
              ),
              ElevatedButton(
                onPressed: () {
                  // Lógica para editar perfil
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Cor do botão
                  foregroundColor: Colors.white, // Cor do texto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text('Editar Perfil', style: TextStyle(fontSize: 18)),
              ),
              ElevatedButton(
                onPressed: () async {
                  await userService.logOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Cor do botão de logout
                  foregroundColor: Colors.white, // Cor do texto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text('Desconectar', style: TextStyle(fontSize: 18)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
