import 'package:http/http.dart' as http;

class ServerConnection {
  String _username;
  String _password;
  String _server;

  ServerConnection(this._username, this._password, this._server);
}