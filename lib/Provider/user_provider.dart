import 'package:amazon_clone/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  User_model _user = User_model(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
    cart: [],
  );

  User_model get user => _user;

  void setUser(String user) {
    _user = User_model.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User_model user) {
    _user = user;
    notifyListeners();
  }
}
