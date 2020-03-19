import 'package:flutter/material.dart';
import 'package:tak_ui/server/server_interface.dart';
import 'server/server.dart';

class HomeScreen extends StatelessWidget {
  final TakServer _connection;

  HomeScreen(this._connection);

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_connection.getUsername()),
      ),
      body: Center(child: Text('Welcome ' + _connection.getUsername())),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('Friends'),
            icon: Icon(Icons.supervised_user_circle),
          ),
          BottomNavigationBarItem(
            title: Text('Games'),
            icon: Icon(Icons.videogame_asset),
          ),
          BottomNavigationBarItem(
            title: Text('Notifications'),
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
    );
  }
}
