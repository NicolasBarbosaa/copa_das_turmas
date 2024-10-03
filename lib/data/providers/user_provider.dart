import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String _userType = 'guest'; // guest, admin, representative

  String get userType => _userType;

  void logInAsAdmin() {
    _userType = 'admin';
    notifyListeners();
  }

  void logInAsRepresentative() {
    _userType = 'representative';
    notifyListeners();
  }
}
