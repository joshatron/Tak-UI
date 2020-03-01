import 'package:flutter/material.dart';
import 'server.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _serverController = TextEditingController();
  final _usernameFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _serverFocus = FocusNode();

  _tryLogin() async {
    print(await ServerConnection.isAuthenticated(_usernameController.text, _passwordController.text, _serverController.text));
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _serverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Tak")
      ),
      body: ScrollConfiguration(
          behavior: NoScrollGlowBehavior(),
          child: ListView(
            children: <Widget>[
              Image(image: AssetImage("images/tak.jpg"),),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  controller: _usernameController,
                  focusNode: _usernameFocus,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    _fieldFocusChange(context, _usernameFocus, _passwordFocus);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    _fieldFocusChange(context, _passwordFocus, _serverFocus);
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  controller: _serverController,
                  focusNode: _serverFocus,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Server',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.grey[300],
                      onPressed: () {_tryLogin();},
                      child: Text("Login"),
                    ),
                    FlatButton(
                      color: Colors.grey[300],
                      onPressed: () {},
                      child: Text("Register"),
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}

class NoScrollGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
