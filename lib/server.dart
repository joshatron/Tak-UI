import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as http;

class ServerConnection {
  String _username;
  String _password;
  String _server;

  String get username => _username;
  String get server => _server;

  ServerConnection(this._username, this._password, this._server);

  String getAuth() {
    var bytes = utf8.encode('$_username:$_password');
    return 'Basic ' + base64.encode(bytes);
  }

  static http.IOClient getClient() {
    return http.IOClient(
        new HttpClient()..badCertificateCallback = (cert, host, port) => true);
  }
}

Future<bool> isAuthenticated(ServerConnection conn) async {
  final response = await ServerConnection.getClient().get(
    conn.server + '/account/authenticate',
    headers: {HttpHeaders.authorizationHeader: conn.getAuth()},
  );

  if(response.statusCode == 204) {
    return true;
  }
  else if(response.statusCode == 401) {
    return false;
  }
  throw Exception("Server returned an error");
}

Future<bool> register(String server, String username, String password) async {
  final response = await ServerConnection.getClient().post(
    server + '/account/register',
    body: jsonEncode(<String,String>{
      'username': username,
      'password': password,
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
