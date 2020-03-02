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

  static String _getAuth(String username, String password) {
    var bytes = utf8.encode('$username:$password');
    return 'Basic ' + base64.encode(bytes);
  }

  static http.IOClient getHttp() {
    return http.IOClient(new HttpClient()..badCertificateCallback = (cert, host, port) => true);
  }

  static Future<bool> isAuthenticated(String username, String password, String server) async {
    final response = await getHttp().get(
      '$server/account/authenticate',
      headers: {HttpHeaders.authorizationHeader: _getAuth(username, password)},
    );
    print(response);

    if(response.statusCode == 204) {
      return true;
    }
    else if(response.statusCode == 401) {
      return false;
    }
    throw Exception("Server returned an error");
  }

  Future<bool> register() async {
    final response = await getHttp().post(
      '$_server/account/register',
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
}