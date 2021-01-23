import 'package:flutter/cupertino.dart';

class AuthCredentials extends ChangeNotifier {
  String accessToken;
  String refreshToken;
  String displayName;
  String role;
  String id;

  AuthCredentials(
      {this.accessToken,
      this.refreshToken,
      this.displayName,
      this.role,
      this.id});

  factory AuthCredentials.fromJson(Map<String, dynamic> json) {
    return AuthCredentials(
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
        displayName: json['displayName'],
        role: json['role'],
        id: json['id']);
  }

  void createNewCredentials(AuthCredentials authCredentials) {
    accessToken = authCredentials.accessToken;
    refreshToken = authCredentials.refreshToken;
    displayName = authCredentials.displayName;
    role = authCredentials.role;
    id = authCredentials.id;
    notifyListeners();
  }

  void setDefault() {
    accessToken = null;
    refreshToken = null;
    displayName = null;
    role = null;
    id = null;
    notifyListeners();
  }

  @override
  void dispose() {
    print('AuthCredentials disposed');
    super.dispose();
  }
}
