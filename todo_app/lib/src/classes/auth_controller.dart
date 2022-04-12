import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/src/classes/user_model.dart';

class AuthController with ChangeNotifier {
  final Box accountsCache = Hive.box('accounts');
  final Box autoLogin = Hive.box('auto_log');
  User? currentUser;
  List<User> users = [];

  

  AuthController() {
    List result = accountsCache.get('users', defaultValue: []);
    final thisUser = autoLogin.get('current_user', defaultValue: null);

    print(result);
    for (var entry in result) {
      print(entry);
      users.add(User.fromJson(Map<String, dynamic>.from(entry)));
    }
    notifyListeners();
    
    if (thisUser != null) {
      currentUser = User.fromJson(Map<String, dynamic>.from(thisUser));
    }
  }

  String register(String username, String password) {
    if (userExists(username) != null) {
      return 'Error: The username is already taken';
    } else {
      users.add(User(username: username, password: password));
      saveDataToCache();
      return 'User successfully registered';
    }
  }

  bool login(String username, String password) {
    User? userSearchResult = userExists(username);
    if (userSearchResult != null) {
      bool result = userSearchResult.login(username, password);
      if (result) {
        currentUser = userSearchResult;
        autoLogin.put('current_user', currentUser!.toJson());
        notifyListeners();
      }
      return result;
    } else {
      return false;
    }
  }

  logout() {
    currentUser = null;
    autoLogin.put('current_user', null);
    notifyListeners();
  }

  User? userExists(String username) {
    for (User user in users) {
      if (user.exists(username)) return user;
    }
    return null;
  }

  saveDataToCache() {
    List<Map<String, dynamic>> dataToStore = [];
    for (User user in users) {
      dataToStore.add(user.toJson());
    }
    print(dataToStore);
    accountsCache.put('users', dataToStore);
    notifyListeners();
  }
}
