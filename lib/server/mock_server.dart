import 'package:tak_ui/server/tak_server.dart';

class MockServer implements TakServer {
  String _username;
  String _password;
  String _server;

  @override
  String getUsername() {
    return _username;
  }

  @override
  String getServer() {
    return _server;
  }

  @override
  void initialize(String username, String password, String server) {
    _username = username;
    _password = password;
    _server = server;
  }

  @override
  Future<bool> register() {
    if(_server.endsWith('wrong')) {
      return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }

  @override
  Future<bool> isAuthenticated() {
    if(_password == 'wrong') {
      return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }

  @override
  bool localAuth(String password) {
    return password == _password;
  }

  @override
  Future<bool> changeUsername(String username) {
    if(username == 'wrong') {
      return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }

  @override
  Future<bool> changePassword(String password) {
    if(password == 'wrong') {
      return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }
}