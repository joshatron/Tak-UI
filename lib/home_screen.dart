import 'package:flutter/material.dart';
import 'server.dart';

class HomeScreen extends StatelessWidget {
  final ServerConnection _connection;

  HomeScreen(this._connection);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text(_connection.username)),
      body: Center(child: Text('Welcome ' + _connection.username)),
    );
  }
}
