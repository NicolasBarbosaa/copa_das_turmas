import 'package:copa_turmas/features/user/service/login_user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);

    List<BottomNavigationBarItem> items = [];

    // Definindo as opções do BottomNavigationBar com base no tipo de usuário
    if (userService.userType == 'guest') {
      items = [
        bottomNavigationBarItem(Icons.home_outlined, 'Home'),
        bottomNavigationBarItem(Icons.person_outline, 'Profile'),
      ];
    } else if (userService.userType == 'representative') {
      items = [
        bottomNavigationBarItem(Icons.home_outlined, 'Home'),
        bottomNavigationBarItem(Icons.bar_chart_outlined, 'Stats'),
        bottomNavigationBarItem(Icons.person_outline, 'Profile'),
      ];
    } else if (userService.userType == 'admin') {
      items = [
        bottomNavigationBarItem(Icons.home_outlined, 'Home'),
        bottomNavigationBarItem(Icons.bar_chart_outlined, 'Stats'),
        bottomNavigationBarItem(Icons.chat_bubble_outline, 'Chat'),
        bottomNavigationBarItem(Icons.person_outline, 'Profile'),
      ];
    }

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: items,
    );
  }
}

BottomNavigationBarItem bottomNavigationBarItem(IconData icon, String label) {
  return BottomNavigationBarItem(
    icon: Icon(icon),
    label: label,
  );
}
