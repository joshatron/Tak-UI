import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as http;

class ServerConnection {
  String _username;
  String _password;
  String _server;

  ServerConnection(this._username, this._password, this._server);

  static Future<bool> isAuthenticated(String username, String password, String server) async {
    var https = new http.IOClient(new HttpClient()..badCertificateCallback = (cert, host, port) => true);
    final response = await https.get(
      '$server/account/authenticate',
      headers: {HttpHeaders.authorizationHeader: _getAuth(username, password)},
    );

    if(response.statusCode == 204) {
      return true;
    }
    else if(response.statusCode == 401) {
      return false;
    }
    throw Exception("Server returned an error");
  }

  static String _getAuth(String username, String password) {
    var bytes = utf8.encode('$username:$password');
    return 'Basic ' + base64.encode(bytes);
  }
}