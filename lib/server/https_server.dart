import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as http;
import 'package:tak_ui/server/tak_server.dart';

class HttpsServer implements TakServer {
  String _username;
  String _password;
  String _server;

  String _getAuth() {
    var bytes = utf8.encode('$_username:$_password');
    return 'Basic ' + base64.encode(bytes);
  }

  static http.IOClient _getClient() {
    return http.IOClient(
        new HttpClient()..badCertificateCallback = (cert, host, port) => true);
  }

  @override
  void initialize(String username, String password, String server) {
    _username = username;
    _password = password;
    _server = server;
  }

  @override
  String getUsername() {
    return _username;
  }

  @override
  String getServer() {
    return _server;
  }

  @override
  Future<bool> register() async {
    final response = await _getClient().post(
      _server + '/account/register',
      body: jsonEncode(<String,String>{
        'username': _username,
        'password': _password,
      }),
    );

    if(response.statusCode == 204) {
      return true;
    }
    else if(response.statusCode == 403) {
      return false;
    }
    throw Exception("Server returned an error");
  }

  @override
  Future<bool> isAuthenticated() async {
    final response = await _getClient().get(
      _server + '/account/authenticate',
      headers: {HttpHeaders.authorizationHeader: _getAuth()},
    );

    if(response.statusCode == 204) {
      return true;
    }
    else if(response.statusCode == 401) {
      return false;
    }
    throw Exception("Server returned an error");
  }

  @override
  bool localAuth(String password) {
    return password == _password;
  }

  @override
  Future<bool> changeUsername(String username) async {
    final response = await _getClient().post(
      _server + '/account/change-name',
      headers: {HttpHeaders.authorizationHeader: _getAuth()},
      body: jsonEncode(<String,String>{
        'username': username,
      }),
    );

    if(response.statusCode == 204) {
      _username = username;
      return true;
    }
    else if(response.statusCode == 403) {
      return false;
    }
    throw Exception("Server returned an error");
  }

  @override
  Future<bool> changePassword(String password) async {
    final response = await _getClient().post(
      _server + '/account/change-pass',
      headers: {HttpHeaders.authorizationHeader: _getAuth()},
      body: jsonEncode(<String,String>{
        'password': password,
      }),
    );

    if(response.statusCode == 204) {
      _password = password;
      return true;
    }
    else if(response.statusCode == 401) {
      return false;
    }
    throw Exception("Server returned an error");
  }
}
