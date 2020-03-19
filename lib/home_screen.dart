import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tak_ui/server/tak_server.dart';
import 'server/https_server.dart';

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
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_arrow,
        backgroundColor: Colors.brown,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            child: Icon(Icons.videogame_asset),
            backgroundColor: Colors.brown,
            label: 'New Game',
          ),
          SpeedDialChild(
            child: Icon(Icons.person_add),
            backgroundColor: Colors.brown,
            label: 'New Friend',
          ),
        ],
      ),
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
