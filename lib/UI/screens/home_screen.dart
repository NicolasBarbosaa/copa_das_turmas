import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/user/service/login_user_service.dart';
import '../widgets/custom_bottom_navigator.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);

    List<Widget> pages = [];

    // Personalizar páginas com base no tipo de usuário
    if (userService.userType == 'guest') {
      pages = [
        Center(child: Text('Bem-vindo, Convidado!')), // Página inicial para convidado
        ProfilePage(), // Página de perfil do convidado com o botão "Conectar"
      ];
    } else if (userService.userType == 'representative') {
      pages = [
        Center(child: Text('Página Home para Representante')),
        Center(child: Text('Estatísticas da Turma')),
        ProfilePage(), // Perfil do representante com foto
      ];
    } else if (userService.userType == 'admin') {
      pages = [
        Center(child: Text('Página Home para Admin')),
        Center(child: Text('Estatísticas Gerais')),
        Center(child: Text('Chat para Admin')),
        ProfilePage(), // Perfil do admin com foto
      ];
    }

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
